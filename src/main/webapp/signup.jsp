<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Customer Signup</title>
<script src="https://cdn.tailwindcss.com"></script>
<script>
		document.addEventListener("visibilitychange", function () {
    	if (!document.hidden) {
        location.reload();
    	}
		});
	</script>
</head>

<body class="min-h-screen bg-[#0c0f12] text-slate-100 flex items-center justify-center">

<div class="w-full max-w-md bg-slate-900/70 border border-blue-500/40 rounded-2xl p-8">
    <h1 class="text-2xl font-semibold text-center mb-6">
        <span class="bg-gradient-to-r from-[#ff003c] to-[#ff6a88] bg-clip-text text-transparent drop-shadow-[0_0_10px_#ff003c]">
            Sapphire :
        </span>
        <span class="bg-gradient-to-r from-[#d7d7d7] to-[#ffffff] bg-clip-text text-transparent drop-shadow-[0_0_10px_#cccccc]">
            The Family Restaurant
        </span>
    </h1>
    <h1 class="text-3xl font-semibold mb-4 text-center">
        Customer <span class="text-blue-400">Signup</span>
    </h1>

    <form action="signup" method="post" class="space-y-4">
        <div>
            <label class="block text-sm mb-1">Full Name</label>
            <input type="text" name="name" required
                   class="w-full bg-slate-800/70 border border-slate-600 rounded-lg px-3 py-2">
        </div>

        <div>
            <label class="block text-sm mb-1">Username</label>
            <input type="text" name="username" required
                   class="w-full bg-slate-800/70 border border-slate-600 rounded-lg px-3 py-2">
        </div>

        <div>
            <label class="block text-sm mb-1">Password</label>
            <input type="password" name="password" required
                   class="w-full bg-slate-800/70 border border-slate-600 rounded-lg px-3 py-2">
        </div>

        <button type="submit"
                class="w-full bg-gradient-to-r from-blue-500 to-purple-600 py-2 rounded-lg text-slate-100 font-semibold">
            Create Account
        </button>

        <p class="text-center text-sm text-slate-400 mt-3">
            Already have an account?
            <a href="index.jsp" class="text-blue-400">Login</a>
        </p>
    </form>
</div>

</body>
</html>
