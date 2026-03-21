<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Restaurant Login</title>
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
<div class="w-full max-w-md bg-slate-900/70 border border-accent/40 rounded-2xl p-8 shadow-2xl shadow-accent/40">

    <h1 class="text-2xl font-semibold text-center mb-6">
        <span class="bg-gradient-to-r from-[#ff003c] to-[#ff6a88] bg-clip-text text-transparent drop-shadow-[0_0_10px_#ff003c]">
            Sapphire :
        </span>
        <span class="bg-gradient-to-r from-[#d7d7d7] to-[#ffffff] bg-clip-text text-transparent drop-shadow-[0_0_10px_#cccccc]">
            The Family Restaurant
        </span>
    </h1>

    <p class="text-sm text-slate-400 text-center mb-6">
        Sign in to access the dashboard
    </p>

    <form action="login" method="post" class="space-y-4">
        <div>
            <label class="block text-sm mb-1">Username</label>
            <input type="text" name="username" required
                   class="w-full bg-slate-800/80 border border-slate-600 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-neon">
        </div>

        <div>
            <label class="block text-sm mb-1">Password</label>
            <input type="password" name="password" required
                   class="w-full bg-slate-800/80 border border-slate-600 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-neon">
        </div>

        <button type="submit"
                class="w-full mt-4 bg-gradient-to-r from-neon to-accent 
                       text-slate-900 font-semibold py-2 rounded-lg hover:opacity-90 transition">
            Login
        </button>
    </form>

    <p class="text-center mt-5 text-sm text-slate-400">
        Don’t have an account?
        <a href="signup.jsp" class="text-neon hover:underline">
            Create one
        </a>
    </p>

</div>
</body>
</html>
