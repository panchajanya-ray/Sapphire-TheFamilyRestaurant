<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Map"%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<%
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
		response.setHeader("Pragma", "no-cache"); // HTTP 1.0
		response.setHeader("Expires","0"); // Proxies
		if(session.getAttribute("user")==null)
		{
			response.sendRedirect("index.jsp");
			return;
		}
%>

<%
Map<String, Double> oDay = (Map)request.getAttribute("ordersDay");
Map<String, Double> oMonth = (Map)request.getAttribute("ordersMonth");
Map<String, Double> oYear = (Map)request.getAttribute("ordersYear");

Map<String, Integer> rDay = (Map)request.getAttribute("resDay");
Map<String, Integer> rMonth = (Map)request.getAttribute("resMonth");
Map<String, Integer> rYear = (Map)request.getAttribute("resYear");
%>

<!DOCTYPE html>
<html>
<head>
<title>Reports</title>

<script src="https://cdn.tailwindcss.com"></script>
<script>
tailwind.config = {
    theme: {
        extend: {
            colors: {
                bgdark: '#0c0f12',
                neon: '#00aaff',
                accent: '#6f00ff'
            }
        }
    }
}
</script>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>


<body class="min-h-screen bg-bgdark text-slate-100">
<!-- Header -->
<div class="max-w-6xl mx-auto px-4 py-8">
    <div class="flex justify-between items-center mb-6">

        <div>
            <h2 class="text-2xl font-semibold"><span class="text-neon">Reports</span></h2>
            <p class="text-sm text-slate-400">Sales and performance analytics.</p>
        </div>

        <h1 class="text-2xl font-semibold inline-block text-center">
            <span class="bg-gradient-to-r from-[#ff003c] to-[#ff6a88] 
                bg-clip-text text-transparent drop-shadow-[0_0_10px_#ff003c]">
                Sapphire :
            </span>
            <span class="bg-gradient-to-r from-[#d7d7d7] to-[#ffffff] 
                bg-clip-text text-transparent drop-shadow-[0_0_10px_#cccccc]">
                The Family Restaurant
            </span>
        </h1>

        <a href="dashboard.jsp"
           class="text-sm px-3 py-1 rounded-full border border-neon/70 text-neon hover:bg-neon/10">
            Back to Dashboard
        </a>
    </div>
</br></br></br>
<div class="space-y-10">

<!-- ORDERS -->
<div class="bg-slate-900/70 border border-slate-700 rounded-2xl p-6 mb-8">
<div class="flex justify-between mb-2">
<h3 class="text-lg text-cyan-400">Orders</h3>
<select onchange="loadOrders(this.value)" class="bg-slate-900 border border-slate-700 rounded-lg px-2 py-2 text-sm text-slate-100 focus:outline-none">
<option value="day">Day</option>
<option value="month">Month</option>
<option value="year">Year</option>
</select>
</div>
<div class="h-80"><canvas id="ordersChart"></canvas></div>
</div>
</br></br>

<!-- RESERVATIONS -->
<div class="bg-slate-900/70 border border-slate-700 rounded-2xl p-6 mb-8">
<div class="flex justify-between mb-2">
<h3 class="text-lg text-[#ff003c]">Reservations</h3>
<select onchange="loadRes(this.value)" class="bg-slate-900 border border-slate-700 rounded-lg px-2 py-2 text-sm text-slate-100 focus:outline-none">
<option value="day">Day</option>
<option value="month">Month</option>
<option value="year">Year</option>
</select>
</div>
<div class="h-80"><canvas id="resChart"></canvas></div>
</div>
</br></br></br>

<!-- TOTAL -->
<div class="bg-slate-900/70 border border-slate-700 rounded-2xl p-6 mb-8">
<div class="flex justify-between mb-2">
<h3 class="text-lg text-emerald-400">Total Sales</h3>
<select onchange="loadTotal(this.value)" class="bg-slate-900 border border-slate-700 rounded-lg px-2 py-2 text-sm text-slate-100 focus:outline-none">
<option value="day">Day</option>
<option value="month">Month</option>
<option value="year">Year</option>
</select>
</div>
<div class="h-80"><canvas id="totalChart"></canvas></div>
</div>

</div>

<script>
const orders = {
day: { labels:[<%=String.join(",",oDay.keySet().stream().map(d->"'"+d+"'").toList())%>],
       data:[<%=String.join(",",oDay.values().stream().map(String::valueOf).toList())%>] },
month:{ labels:[<%=String.join(",",oMonth.keySet().stream().map(d->"'"+d+"'").toList())%>],
       data:[<%=String.join(",",oMonth.values().stream().map(String::valueOf).toList())%>] },
year: { labels:[<%=String.join(",",oYear.keySet().stream().map(d->"'"+d+"'").toList())%>],
       data:[<%=String.join(",",oYear.values().stream().map(String::valueOf).toList())%>] }
};

const res = {
day: { labels:[<%=String.join(",",rDay.keySet().stream().map(d->"'"+d+"'").toList())%>],
       data:[<%=String.join(",",rDay.values().stream().map(String::valueOf).toList())%>] },
month:{ labels:[<%=String.join(",",rMonth.keySet().stream().map(d->"'"+d+"'").toList())%>],
       data:[<%=String.join(",",rMonth.values().stream().map(String::valueOf).toList())%>] },
year: { labels:[<%=String.join(",",rYear.keySet().stream().map(d->"'"+d+"'").toList())%>],
       data:[<%=String.join(",",rYear.values().stream().map(String::valueOf).toList())%>] }
};

let oChart,rChart,tChart;

function draw(ctx, labels, data, label, color) {
    return new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: label,
                data: data,
                borderColor: color,
                tension: 0.4,
                fill: false
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                }
            }
        }
    });
}



function loadOrders(t='day'){ if(oChart)oChart.destroy();
oChart=draw(document.getElementById("ordersChart"),orders[t].labels,orders[t].data,"Orders","cyan"); }

function loadRes(t='day'){ if(rChart)rChart.destroy();
rChart=draw(document.getElementById("resChart"),res[t].labels,res[t].data,"Reservations","#ff003c"); }

function loadTotal(t='day'){ if(tChart)tChart.destroy();
const total=orders[t].data.map((v,i)=>v+(res[t].data[i]||0));
tChart=draw(document.getElementById("totalChart"),orders[t].labels,total,"Total","#22c55e"); }

loadOrders(); loadRes(); loadTotal();
</script>
</div>
</body>
</html>
