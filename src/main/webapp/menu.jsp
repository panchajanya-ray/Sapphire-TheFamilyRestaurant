<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.restaurantmanagement.model.MenuItem" %>
<%@ page import="com.restaurantmanagement.model.User" %>

<%
		User user = (User) session.getAttribute("user");
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
		response.setHeader("Pragma", "no-cache"); // HTTP 1.0
		response.setHeader("Expires","0"); // Proxies
		if(session.getAttribute("user")==null || !"admin".equalsIgnoreCase(user.getRole()))
		{
			session.removeAttribute("user");
			session.invalidate();
			response.sendRedirect("index.jsp");
			return;
		}
%>
	
<%
    List<MenuItem> items = (List<MenuItem>) request.getAttribute("items");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Menu Management</title>
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
<body class="min-h-screen bg-bgdark text-slate-100">
<div class="max-w-6xl mx-auto px-4 py-8">
    <div class="flex justify-between items-center mb-6">
        <div>
            <h2 class="text-2xl font-semibold">Menu <span class="text-neon">Management</span></h2>
            <p class="text-sm text-slate-400">Add new items and view existing menu.</p>
        </div>
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
        <a href="dashboard.jsp"
           class="text-sm px-3 py-1 rounded-full border border-neon/70 text-neon hover:bg-neon/10">
            Back to Dashboard
        </a>
    </div>

    <!-- Add Item Form -->
    <div class="bg-slate-900/70 border border-slate-700 rounded-2xl p-6 mb-8">
        <h3 class="text-lg font-semibold mb-4 text-neon">Add New Menu Item</h3>
        <form action="menu" method="post" class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
                <label class="block text-sm mb-1">Item Name</label>
                <input type="text" name="name" required
                       class="w-full bg-slate-800/80 border border-slate-600 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-neon">
            </div>
            <div>
                <label class="block text-sm mb-1">Category</label>
                <input type="text" name="category"
                       class="w-full bg-slate-800/80 border border-slate-600 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-neon">
            </div>
            <div>
                <label class="block text-sm mb-1">Price (₹)</label>
                <input type="number" step="0.01" name="price" required
                       class="w-full bg-slate-800/80 border border-slate-600 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-neon">
            </div>
            <div>
                <label class="block text-sm mb-1">Description</label>
                <input type="text" name="description"
                       class="w-full bg-slate-800/80 border border-slate-600 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-neon">
            </div>
            <div class="md:col-span-2 flex justify-end">
                <button type="submit"
                        class="bg-gradient-to-r from-neon to-accent text-slate-900 font-semibold px-5 py-2 rounded-lg hover:opacity-90 transition">
                    Add Item
                </button>
            </div>
        </form>
    </div>

    <!-- Menu Table -->
    <div class="bg-slate-900/70 border border-slate-700 rounded-2xl p-6">
        <h3 class="text-lg font-semibold mb-4 text-neon">Current Menu</h3>
        <div class="overflow-x-auto">
            <table class="min-w-full text-sm">
                <thead>
                <tr class="bg-slate-800/80 text-slate-300">
                    <th class="px-3 py-2 text-left">ID</th>
                    <th class="px-3 py-2 text-left">Name</th>
                    <th class="px-3 py-2 text-left">Category</th>
                    <th class="px-3 py-2 text-right">Price (₹)</th>
                    <th class="px-3 py-2 text-left">Description</th>
                    <th class="px-3 py-2 text-center">Status</th>
                </tr>
                </thead>
                <tbody>
                <%
                    if (items != null) {
                        for (MenuItem m : items) {
                %>
                <tr class="border-t border-slate-800 hover:bg-slate-800/60">
                    <td class="px-3 py-2"><%= m.getId() %></td>
                    <td class="px-3 py-2"><%= m.getItemName() %></td>
                    <td class="px-3 py-2"><%= m.getCategory() %></td>
                    <td class="px-3 py-2 text-right"><%= m.getPrice() %></td>
                    <td class="px-3 py-2"><%= m.getDescription() %></td>
                    <td class="px-3 py-2 text-center">
                    	<% if ("available".equalsIgnoreCase(m.getStatus())) { %>
                    	<a href="updateAvailableStatus?id=<%= m.getId() %>&status=not available"
                    	class="text-xs px-2 py-1 rounded-full border border-emerald-500/60 text-emerald-400">
                    	<%= m.getStatus() %>
                    	</a>
                    	
                    	<% } else if ("not available".equalsIgnoreCase(m.getStatus())) { %>
                    	<a href="updateAvailableStatus?id=<%= m.getId() %>&status=available"
                    	class="text-xs px-2 py-1 rounded-full border border-[#ff0048]/60 text-[#ff0048]">
                    	<%= m.getStatus() %>
                    	</a>
                    	
                    	<% } %>
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
