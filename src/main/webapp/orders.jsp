<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.restaurantmanagement.model.Order" %>
<%@ page import="com.restaurantmanagement.model.MenuItem" %>
<%@ page import="com.restaurantmanagement.model.User" %>


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
	User user = (User) session.getAttribute("user");
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    List<MenuItem> menuItems = (List<MenuItem>) request.getAttribute("menuItems");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Orders</title>
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
    

    <script>
        var menuData = {};
        <% if (menuItems != null) {
               for (MenuItem m : menuItems) { %>
                   menuData["<%= m.getId() %>"] = {
                       name: "<%= m.getItemName().replace("\"","\\\"") %>",
                       price: <%= m.getPrice() %>
                   };
        <%     }
           }
        %>

        function recalcRow(rowIndex) {
            var qty = parseFloat(document.getElementById("qty_" + rowIndex).value || "0");
            var price = parseFloat(document.getElementById("price_" + rowIndex).value || "0");
            var discount = parseFloat(document.getElementById("discount_" + rowIndex).value || "0");

            var subTotal = qty * price;
            var discAmt = subTotal * (discount / 100.0);
            var lineTotal = subTotal - discAmt;

            document.getElementById("lineTotal_" + rowIndex).value = lineTotal.toFixed(2);

            recalcGrandTotal();
        }

        function recalcGrandTotal() {
            var i = 0;
            var grand = 0.0;
            while (true) {
                var lt = document.getElementById("lineTotal_" + i);
                if (!lt) break;
                var v = parseFloat(lt.value || "0");
                grand += v;
                i++;
            }
            document.getElementById("grandTotalDisplay").innerText = grand.toFixed(2);
        }

        function onItemChange(rowIndex) {
            var select = document.getElementById("item_" + rowIndex);
            var itemId = select.value;
            if (itemId && menuData[itemId]) {
                document.getElementById("price_" + rowIndex).value = menuData[itemId].price;
                document.getElementById("itemName_" + rowIndex).value = menuData[itemId].name;
            } else {
                document.getElementById("price_" + rowIndex).value = "";
                document.getElementById("itemName_" + rowIndex).value = "";
            }
            recalcRow(rowIndex);
        }

        function addRow() {
            var container = document.getElementById("itemsContainer");
            var index = container.children.length;

            var row = document.createElement("div");
            row.id = "row_" + index;
            row.className = "flex flex-wrap items-end gap-3 mb-3";

            row.innerHTML =
                '<div class="flex flex-col min-w-[180px]">' +
                    '<span class="text-xs text-slate-400 mb-1">Item</span>' +
                    '<select name="menuItemId" id="item_' + index + '" onchange="onItemChange(' + index + ')" ' +
                        'class="bg-slate-900 border border-slate-700 rounded-lg px-2 py-2 text-sm text-slate-100 focus:outline-none focus:ring-2 focus:ring-neon">' +
                        '<option value="">--select--</option>' +
                        <% if (menuItems != null) {
                               for (MenuItem m : menuItems) { %>
                                   '<option value="<%= m.getId() %>"><%= m.getItemName().replace("\"","\\\"") %></option>' +
                        <%     }
                           } %>
                    '</select>' +
                    '<input type="hidden" name="itemName_' + index + '" id="itemName_' + index + '">' +
                '</div>' +
                '<div class="flex flex-col w-20">' +
                    '<span class="text-xs text-slate-400 mb-1">Qty</span>' +
                    '<input type="number" name="quantity" id="qty_' + index + '" value="1" min="1" ' +
                           'oninput="recalcRow(' + index + ')" ' +
                           'class="bg-slate-900 border border-slate-700 rounded-lg px-2 py-2 text-sm text-slate-100 focus:outline-none focus:ring-2 focus:ring-neon">' +
                '</div>' +
                '<div class="flex flex-col w-32">' +
                    '<span class="text-xs text-slate-400 mb-1">Price (₹)</span>' +
                    '<input type="number" step="0.01" name="price" id="price_' + index + '" readonly ' +
                           'class="bg-slate-900 border border-slate-700 rounded-lg px-2 py-2 text-sm text-slate-100">' +
                '</div>' +
                
                '<div class="flex flex-col w-32">' +
                    '<span class="text-xs text-slate-400 mb-1">Discount (%)</span>' +
                    '<input type="number" step="0.01" name="discount" id="discount_' + index + '" value="0" ' +
                           'oninput="recalcRow(' + index + ')" ' +
                           'class="bg-slate-900 border border-slate-700 rounded-lg px-2 py-2 text-sm text-slate-100 focus:outline-none focus:ring-2 focus:ring-neon">' +
                '</div>' +
                
                '<div class="flex flex-col w-32">' +
                    '<span class="text-xs text-slate-400 mb-1">Line Total (₹)</span>' +
                    '<input type="text" id="lineTotal_' + index + '" readonly ' +
                           'class="bg-slate-900 border border-slate-700 rounded-lg px-2 py-2 text-sm text-slate-100">' +
                '</div>';

            container.appendChild(row);
        }

        window.onload = function() {
            addRow();
        };
    </script>
</head>
<body class="min-h-screen bg-bgdark text-slate-100">
<div class="max-w-6xl mx-auto px-4 py-8">

    <div class="flex justify-between items-center mb-6">
        <div>
            <h2 class="text-2xl font-semibold">Order <span class="text-neon">Management</span></h2>
            <p class="text-sm text-slate-400">Create new orders and review order history.</p>
        </div><h1 class="text-2xl font-semibold inline-block">
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

    <!-- New Order Form -->
    <div class="bg-slate-900/70 border border-slate-700 rounded-2xl p-6 mb-8">
        <h3 class="text-lg font-semibold mb-4 text-neon">Create New Order</h3>

        <form action="orders" method="post" class="space-y-4">
            <div>
                <label class="block text-sm mb-1">Customer Name</label>
                <input type="text" name="customerName" required
                       class="w-full max-w-sm bg-slate-800/80 border border-slate-600 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-neon">
            </div>

            <div id="itemsContainer" class="space-y-2"></div>

            <button type="button"
                    onclick="addRow()"
                    class="text-sm px-3 py-1 rounded-full border border-neon/70 text-neon hover:bg-neon/10">
                + Add Item
            </button>

            <div class="flex justify-between items-center mt-4">
                <div class="text-sm text-slate-300">
                    Grand Total: <span id="grandTotalDisplay" class="text-neon font-semibold">0.00</span> ₹
                </div>
                <button type="submit"
                        class="bg-gradient-to-r from-neon to-accent text-slate-900 font-semibold px-6 py-2 rounded-lg hover:opacity-90 transition">
                    Place Order &amp; Generate Invoice
                </button>
            </div>
        </form>
    </div>
	
    <!-- Previous Orders -->
    <div class="bg-slate-900/70 border border-slate-700 rounded-2xl p-6">
        <div class="sticky top-0 z-20 bg-slate-900/70 border-b border-slate-800 mb-4">
    <div class="flex items-center justify-between py-3">

        <div class="flex items-center gap-3">
            <h3 class="text-lg font-semibold text-neon">
                Orders
            </h3>
            <span class="text-xs px-2 py-1 rounded-full
                         border-[#ff003c]/60 text-[#ff003c] drop-shadow-[0_0_6px_#ff003c]">
                <%= request.getAttribute("orderCount") %> total
            </span>
        </div>

        <form method="get" action="orders" class="flex items-center gap-3">
            <label class="text-sm text-slate-400">Date:</label>

            <input type="date"
                   name="date"
                   value="<%= request.getAttribute("selectedDate") %>"
                   onchange="this.form.submit()"
                   class="bg-slate-800 border border-slate-600 rounded-lg px-3 py-1 text-sm
                          focus:outline-none focus:ring-2 focus:ring-neon"
                   
                          >

            <noscript>
                <button type="submit"
                        class="text-sm px-3 py-1 rounded-full border border-neon/70 text-neon">
                    View
                </button>
            </noscript>
        </form>

    </div>
</div>
        <div class="overflow-x-auto">
            <table class="min-w-full text-sm">
                <thead>
                <tr class="bg-slate-800/80 text-slate-300">
                    <th class="px-3 py-2 text-left">ID</th>
                    <th class="px-3 py-2 text-left">User ID</th>
                    <th class="px-3 py-2 text-left">Customer</th>
                    <th class="px-3 py-2 text-left">Time</th>
                    <th class="px-3 py-2 text-right">Total (₹)</th>
                    <th class="px-3 py-2 text-center">Status</th>
                    <th class="px-3 py-2 text-center">Action</th>
                    <th class="px-3 py-2 text-center">Payment Mode</th>
                </tr>
                </thead>
                <tbody>
                <%
                    if (orders != null) {
                        for (Order o : orders) {
                %>
                <tr class="border-t border-slate-800 hover:bg-slate-800/60">
                    <td class="px-3 py-2"><%= o.getId() %></td>
                    <td class="px-3 py-2"><%= o.getUserId() %></td>
                    <td class="px-3 py-2"><%= o.getCustomerName() %></td>
                    <td class="px-3 py-2"><%= o.getOrderTime() %></td>
                    <td class="px-3 py-2 text-right"><%= o.getTotalAmount() %></td>
                    <td class="px-3 py-2 text-center"><%= o.getStatus() %></td>
                    <td class="px-3 py-2 text-center">
                        <% if (!"paid".equalsIgnoreCase(o.getStatus()) && !"customer".equalsIgnoreCase(user.getRole())) { %>
                            <a href="updateOrderStatus?id=<%= o.getId() %>"
                               class="text-xs px-2 py-1 rounded-full border border-neon/70 text-neon hover:bg-neon/10">
                                Mark as Paid
                            </a>
                        <% } else if (!"paid".equalsIgnoreCase(o.getStatus())&& "customer".equalsIgnoreCase(user.getRole())) { %>
                            <span class="text-xs px-2 py-1 rounded-full border border-[#ff0048]/60 text-[#ff0048]">
                                Not Paid
                            </span>
                        <% } else { %>
                        		<span class="text-xs px-2 py-1 rounded-full border border-emerald-500/60 text-emerald-400">
                                Paid
                            </span>
                           <% } %>
                    </td>
                    <td class="px-3 py-2 text-center"><%= o.getPaymentMethod() %></td>
     
                </tr>
                <%
                        }
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
