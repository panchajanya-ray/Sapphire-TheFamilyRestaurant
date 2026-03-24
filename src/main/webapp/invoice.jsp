<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.restaurantmanagement.model.InvoiceItem" %>


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
    List<InvoiceItem> items = (List<InvoiceItem>) request.getAttribute("invoiceItems");
    String customerName = (String) request.getAttribute("customerName");
    Integer orderIdObj = (Integer) request.getAttribute("orderId");
    Double grandTotalObj = (Double) request.getAttribute("grandTotal");

    int orderId = orderIdObj != null ? orderIdObj : 0;
    double grandTotal = grandTotalObj != null ? grandTotalObj : 0.0;

    double taxRate = 5.0;
    double taxAmount = grandTotal * (taxRate / 100.0);
    double finalTotal = grandTotal + taxAmount;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Invoice</title>
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
    <script>
		document.addEventListener("visibilitychange", function () {
    	if (!document.hidden) {
        location.reload();
    	}
		});
	</script>
</head>
<body class="min-h-screen bg-bgdark text-slate-100 flex items-center justify-center">
<div class="w-full max-w-3xl bg-slate-900/80 border border-accent/50 rounded-2xl p-8 shadow-2xl shadow-accent/40">

<div class="w-full text-center mb-8">
    <h1 class="text-2xl font-semibold inline-block">
        <span class="bg-gradient-to-r from-[#ff003c] to-[#ff6a88] 
            bg-clip-text text-transparent drop-shadow-[0_0_10px_#ff003c]">
            Sapphire :
        </span>
        <span class="bg-gradient-to-r from-[#d7d7d7] to-[#ffffff] 
            bg-clip-text text-transparent drop-shadow-[0_0_10px_#cccccc]">
            The Family Restaurant
        </span>
    </h1>
</div>
    <div class="flex justify-between items-start mb-6">
    
        <div>
            <h1 class="text-2xl font-semibold">
                Restaurant <span class="text-neon">Invoice</span>
            </h1>
            <p class="text-xs text-slate-400 mt-1">
                Thank you for dining with us.
            </p>
        </div>
        <div class="text-right text-sm text-slate-300">
            <div><span class="text-slate-400">Order ID:</span> #<%= orderId %></div>
            <div><span class="text-slate-400">Customer:</span> <%= customerName %></div>
        </div>
    </div>

    <div class="overflow-x-auto mb-4">
        <table class="min-w-full text-xs">
            <thead>
            <tr class="bg-slate-800/90 text-slate-300">
                <th class="px-3 py-2 text-left">Item</th>
                <th class="px-3 py-2 text-center">Qty</th>
                <th class="px-3 py-2 text-right">Unit Price (₹)</th>
                <th class="px-3 py-2 text-center">Discount (%)</th>
                <th class="px-3 py-2 text-right">Line Total (₹)</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (items != null) {
                    for (InvoiceItem it : items) {
            %>
            <tr class="border-t border-slate-800 hover:bg-slate-800/70">
                <td class="px-3 py-2"><%= it.getItemName() %></td>
                <td class="px-3 py-2 text-center"><%= it.getQuantity() %></td>
                <td class="px-3 py-2 text-right"><%= it.getUnitPrice() %></td>
                <td class="px-3 py-2 text-center"><%= it.getDiscountPercent() %></td>
                <td class="px-3 py-2 text-right"><%= it.getLineTotal() %></td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
    </div>

    <div class="flex justify-end mt-4">
        <div class="w-full max-w-xs text-sm space-y-1">
            <div class="flex justify-between">
                <span class="text-slate-400">Subtotal:</span>
                <span class="text-slate-100">₹ <%= String.format("%.2f", grandTotal) %></span>
            </div>
            <div class="flex justify-between">
                <span class="text-slate-400">GST (5%):</span>
                <span class="text-slate-100">₹ <%= String.format("%.2f", taxAmount) %></span>
            </div>
            <div class="flex justify-between border-t border-slate-700 pt-2 mt-1">
                <span class="text-slate-200 font-semibold">Amount Payable:</span>
                <span class="text-neon font-semibold">₹ <%= String.format("%.2f", finalTotal) %></span>
            </div>
        </div>
    </div>
    
    <hr class="my-6 border-slate-700">

<h3 class="text-lg text-neon mb-4">Choose Payment Method</h3>

<div class="flex gap-4">

    <!-- PAY AT COUNTER -->
    <a href="payment?method=counter&orderId=<%= orderId %>&amount=<%= finalTotal %>"
       class="px-4 py-2 border border-emerald-500 text-emerald-400 rounded-lg hover:bg-emerald-500/10">
        Pay at Counter
    </a>

    <!-- PAY USING UPI -->
    <a href="payment?method=upi&orderId=<%= orderId %>&amount=<%= finalTotal %>"
       class="px-4 py-2 border border-neon text-neon rounded-lg hover:bg-neon/10">
        Pay using UPI
    </a>

</div>


    <div class="flex justify-between items-center mt-6">
        <a href="orders"
           class="text-xs px-3 py-1 rounded-full border border-slate-600 text-slate-300 hover:bg-slate-700/60">
            Back to Orders
        </a>
        <a href="dashboard.jsp"
           class="text-xs px-3 py-1 rounded-full border border-neon/70 text-neon hover:bg-neon/10">
            Dashboard
        </a>
    </div>
</div>
</body>
</html>
