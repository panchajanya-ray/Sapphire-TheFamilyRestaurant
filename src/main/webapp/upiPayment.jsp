<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
int orderId = (int) request.getAttribute("orderId");
String amount = (String) request.getAttribute("amount");
%>

<!DOCTYPE html>
<html>
<head>
    <title>UPI Payment</title>

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
</head>

<body class="min-h-screen bg-bgdark text-slate-100 flex items-center justify-center">

<div class="w-full max-w-md bg-slate-900/70 border border-accent/40 rounded-2xl p-8 shadow-2xl shadow-accent/40 text-center">

    <!-- TITLE -->
    <h1 class="text-xl font-semibold mb-4">
        <span class="bg-gradient-to-r from-[#ff003c] to-[#ff6a88] bg-clip-text text-transparent">
            Sapphire :
        </span>
        <span class="bg-gradient-to-r from-[#d7d7d7] to-[#ffffff] bg-clip-text text-transparent">
            The Family Restaurant
        </span>
    </h1>

    <!-- PAYMENT TITLE -->
    <h2 class="text-lg text-neon mb-4">Scan & Pay via UPI</h2>

    <!-- QR CODE -->
    <div class="flex justify-center mb-4">
        <img 
        class="rounded-xl border border-slate-700 p-2 bg-white"
        src="https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=upi://pay?pa=sapphire@upi&pn=SapphireRestaurant&am=<%=amount%>&cu=INR">
    </div>

    <!-- AMOUNT -->
    <p class="text-sm text-slate-400 mb-4">
        Amount: <span class="text-neon font-semibold">₹ <%=amount%></span>
    </p>

    <!-- BUTTONS -->
    <div class="flex justify-center gap-4">

        <button onclick="success()"
            class="px-4 py-2 rounded-lg border border-emerald-500 text-emerald-400 hover:bg-emerald-500/10 transition">
            Payment Done
        </button>

        <button onclick="fail()"
            class="px-4 py-2 rounded-lg border border-red-500 text-red-400 hover:bg-red-500/10 transition">
            Payment Failed
        </button>

    </div>

    <!-- INFO -->
    <p class="text-xs text-slate-500 mt-4">
        After payment, click "Payment Done"
    </p>

</div>

<script>
function success(){
    window.location = "paymentResult?status=success&orderId=<%=orderId%>";
}

function fail(){
    window.location = "paymentResult?status=failed&orderId=<%=orderId%>";
}
</script>

</body>
</html>