<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.restaurantmanagement.model.Reservation" %>
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
    List<Reservation> list = (List<Reservation>) request.getAttribute("reservations");
    User user = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Reservations</title>
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

    <!-- Header -->
    <div class="flex justify-between items-center mb-6">

        <div>
            <h2 class="text-2xl font-semibold">Reservation <span class="text-neon">Management</span></h2>
            <p class="text-sm text-slate-400">Create and manage table bookings.</p>
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


    <!-- Reservation Form (Visible to ALL users) -->
    <div class="bg-slate-900/70 border border-slate-700 rounded-2xl p-6 mb-8">
        <h3 class="text-lg font-semibold mb-4 text-neon">Create New Reservation</h3>

        <form action="reservations" method="post" class="grid grid-cols-1 md:grid-cols-2 gap-4">

            <div>
                <label class="block text-sm mb-1">Customer Name</label>
                <input type="text" name="customerName" required
                       class="w-full bg-slate-800/80 border border-slate-600 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-neon">
            </div>

            <div>
                <label class="block text-sm mb-1">Phone</label>
                <input type="text" name="phone"
                       class="w-full bg-slate-800/80 border border-slate-600 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-neon">
            </div>

            <div>
                <label class="block text-sm mb-1">Date (YYYY-MM-DD)</label>
                <input type="text" name="date" required
                       class="w-full bg-slate-800/80 border border-slate-600 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-neon">
            </div>

            <div>
                <label class="block text-sm mb-1">Time (HH:MM)</label>
                <input type="text" name="time" required
                       class="w-full bg-slate-800/80 border border-slate-600 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-neon">
            </div>

            <div>
                <label class="block text-sm mb-1">Number of People</label>
                <input type="number" name="people" required
                       class="w-full bg-slate-800/80 border border-slate-600 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-neon">
            </div>

            <div class="md:col-span-2 flex justify-end">
                <button type="submit"
                        class="bg-gradient-to-r from-neon to-accent text-slate-900 font-semibold px-6 py-2 rounded-lg hover:opacity-90 transition">
                    Add Reservation
                </button>
            </div>

        </form>
    </div>

    <%
    if (user != null ) { %>

    <div class="bg-slate-900/70 border border-slate-700 rounded-2xl p-6">
      <div class="sticky top-0 z-20 bg-slate-900/70 border-b border-slate-800 mb-4">
    <div class="flex items-center justify-between py-3">

        <div class="flex items-center gap-3">
            <h3 class="text-lg font-semibold text-neon">
                Reservations
            </h3>

            <span class="text-xs px-2 py-1 rounded-full
                         border-[#ff003c]/60 text-[#ff003c] drop-shadow-[0_0_6px_#ff003c]
">
                <%= request.getAttribute("reservationCount") %> total
            </span>
        </div>

        <form method="get" action="reservations" class="flex items-center gap-3">
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
                    <th class="px-3 py-2 text-left">Name</th>
                    <th class="px-3 py-2 text-left">Phone</th>
                    <th class="px-3 py-2 text-left">Date</th>
                    <th class="px-3 py-2 text-left">Time</th>
                    <th class="px-3 py-2 text-right">People</th>
                    <th class="px-3 py-2 text-center">Status</th>
                    <th class="px-3 py-2 text-center">Action</th>
                </tr>
                </thead>

                <tbody>
                <%
                    if (list != null) {
                        for (Reservation r : list) {
                %>
                <tr class="border-t border-slate-800 hover:bg-slate-800/60">

                    <td class="px-3 py-2"><%= r.getId() %></td>
                    <td class="px-3 py-2"><%= r.getCustomerName() %></td>
                    <td class="px-3 py-2"><%= r.getPhone() %></td>
                    <td class="px-3 py-2"><%= r.getReservationDate() %></td>
                    <td class="px-3 py-2"><%= r.getReservationTime() %></td>
                    <td class="px-3 py-2 text-right"><%= r.getPeople() %></td>

                    <td class="px-3 py-2 text-center">
                        <span class="text-xs px-2 py-1 rounded-full border border-neon/60 text-neon">
                            <%= r.getStatus() %>
                        </span>
                    </td>

                    <!-- Cancellation Column -->
                    <td class="px-3 py-2 text-center">

                        <% 
                            boolean canCancel = false;

                            // Admin/staff can cancel all
                            if ("admin".equals(user.getRole()) || "staff".equals(user.getRole())) {
                                canCancel = true;
                            }

                            // Customer can cancel only own bookings
                            if ("customer".equals(user.getRole()) && r.getUserId() == user.getId()) {
                                canCancel = true;
                            }
                     
                        %>

                        <% if (canCancel) { %>
                            <a href="cancelReservation?id=<%= r.getId() %>"
                               class="text-red-400 hover:text-red-600 text-xs font-semibold">
                                Cancel
                            </a>
                        <% } else { %>
                            <span class="text-slate-600 text-xs">---</span>
                        <% } %>

                    </td>

                </tr>
                <%
                        }
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>

    <% } %>

</div>

</body>
</html>
