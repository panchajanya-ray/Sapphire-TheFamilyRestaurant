<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.restaurantmanagement.model.User" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires","0");

    if(session.getAttribute("user")==null){
        response.sendRedirect("index.jsp");
        return;
    }

    User user = (User) session.getAttribute("user");
    boolean isAdmin = "admin".equalsIgnoreCase(user.getRole());
%>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>

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
            if (!document.hidden) location.reload();
        });
    </script>
</head>

<body class="min-h-screen bg-bgdark text-slate-100">

<!-- HEADER -->
<header class="border-b border-slate-800 bg-slate-900/70">
    <div class="max-w-6xl mx-auto flex justify-between items-center px-6 py-4">

        <h1 class="text-xl font-semibold">
            Restaurant <span class="text-neon">Dashboard</span>
        </h1>

        <h1 class="text-lg font-semibold text-center">
            <span class="bg-gradient-to-r from-[#ff003c] to-[#ff6a88]
                bg-clip-text text-transparent drop-shadow-[0_0_8px_#ff003c]">
                Sapphire :
            </span>
            <span class="bg-gradient-to-r from-[#d7d7d7] to-[#ffffff]
                bg-clip-text text-transparent drop-shadow-[0_0_8px_#cccccc]">
                The Family Restaurant
            </span>
        </h1>

        <div class="flex items-center gap-4">
            <div class="text-right">
                <div class="text-sm">
                    Hello, <span class="text-neon"><%= user.getName() %></span>
                </div>
                <div class="text-xs text-slate-400">
                    Role: <%= user.getRole() %>
                </div>
            </div>
            <a href="logout"
               class="text-xs px-3 py-1 rounded-full border border-red-500/60 text-red-400 hover:bg-red-500/10">
                Logout
            </a>
        </div>

    </div>
</header>

<!-- MAIN -->
<main class="min-h-[75vh] flex items-center justify-center px-6">

    <!-- ADMIN: GRID | STAFF/CUSTOMER: ROW -->
    <div class="grid grid-cols-1 md:grid-cols-2 gap-8 max-w-5xl w-full">

        <!-- ORDERS -->
        <a href="orders"
           class="bg-slate-900/70 border border-slate-700 hover:border-neon/70
                  rounded-2xl p-6 min-w-[240px] min-h-[150px]
                  flex flex-col items-center justify-center text-center
                  gap-2 shadow-lg shadow-slate-900/60 hover:shadow-neon/30 transition">

            <div class="text-2xl font-semibold text-neon">
                Order Management
            </div>
            <p class="text-l text-slate-400">
                Create new orders and view order history.
            </p>
        </a>

        <!-- RESERVATIONS -->
        <a href="reservations"
           class="bg-slate-900/70 border border-slate-700 hover:border-neon/70
                  rounded-2xl p-6 min-w-[240px] min-h-[150px]
                  flex flex-col items-center justify-center text-center
                  gap-2 shadow-lg shadow-slate-900/60 hover:shadow-neon/30 transition">

            <div class="text-2xl font-semibold text-neon">
                Reservation Management
            </div>
            <p class="text-l text-slate-400">
                Manage table bookings.
            </p>
        </a>

        <% if (isAdmin) { %>

        <!-- MENU -->
        <a href="menu"
           class="bg-slate-900/70 border border-slate-700 hover:border-neon/70
                  rounded-2xl p-6 min-h-[150px]
                  flex flex-col items-center justify-center text-center
                  gap-2 shadow-lg shadow-slate-900/60 hover:shadow-neon/30 transition">

            <div class="text-2xl font-semibold text-neon">
                Menu Management
            </div>
            <p class="text-l text-slate-400">
                Manage menu items.
            </p>
        </a>

        <!-- REPORTS -->
        <a href="reports"
           class="bg-slate-900/70 border border-slate-700 hover:border-neon/70
                  rounded-2xl p-6 min-h-[150px]
                  flex flex-col items-center justify-center text-center
                  gap-2 shadow-lg shadow-slate-900/60 hover:shadow-neon/30 transition">

            <div class="text-2xl font-semibold text-neon">
                Reports
            </div>
            <p class="text-l text-slate-400">
                Sales analytics.
            </p>
        </a>

        <% } %>

    </div>
</main>

</body>
</html>
