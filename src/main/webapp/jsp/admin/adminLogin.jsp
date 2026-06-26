<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html class="light" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Admin Login - The Academic Curator</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "error-container": "#ffdad6",
                        "on-surface": "#191b23",
                        "secondary": "#495c95",
                        "error": "#ba1a1a",
                        "surface-variant": "#e1e2ed",
                        "outline": "#737686",
                        "primary": "#004ac6",
                        "on-surface-variant": "#434655",
                        "on-error": "#ffffff",
                        "surface-container-lowest": "#ffffff",
                        "surface-container": "#ededf9",
                        "surface-container-high": "#e7e7f3",
                        "primary-container": "#2563eb",
                        "surface": "#faf8ff",
                        "surface-container-low": "#f3f3fe",
                        "on-primary-container": "#eeefff",
                        "on-primary": "#ffffff"
                    },
                    "fontFamily": { "headline": ["Inter"], "body": ["Inter"], "label": ["Inter"] }
                },
            },
        }
    </script>
<style>
    body { font-family: 'Inter', sans-serif; }
    .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; vertical-align: middle; }
    .editorial-shadow { box-shadow: 0px 24px 64px rgba(25, 27, 35, 0.08); }
    .ghost-border { border-bottom: 2px solid rgba(195, 198, 215, 0.2); transition: border-color 0.2s ease; }
    .ghost-border:focus-within { border-color: #004ac6; }
</style>
</head>
<body class="bg-surface text-on-surface min-h-screen flex items-center justify-center p-6 relative overflow-hidden bg-slate-950">
<!-- Background Decal -->
<div class="absolute top-0 right-0 w-[800px] h-[800px] bg-slate-800 rounded-full blur-3xl -translate-y-1/2 translate-x-1/3"></div>
<div class="absolute bottom-0 left-0 w-[600px] h-[600px] bg-blue-900/20 rounded-full blur-3xl translate-y-1/3 -translate-x-1/4"></div>

<div class="w-full max-w-md bg-slate-900/90 backdrop-blur-xl rounded-2xl editorial-shadow border border-slate-700/50 p-10 relative z-10 text-white">
    <div class="text-center mb-10">
        <div class="w-16 h-16 bg-slate-800 text-blue-400 rounded-2xl flex items-center justify-center mx-auto mb-6 shadow-lg border border-slate-700">
            <span class="material-symbols-outlined text-3xl" data-icon="shield">shield</span>
        </div>
        <h1 class="text-3xl font-extrabold tracking-tight mb-2">Admin Portal</h1>
        <p class="text-sm font-medium text-slate-400">Lost &amp; Found Campus Administration</p>
    </div>

    <% if (error != null) { %>
        <div class="mb-6 p-4 bg-error-container/20 text-error-container font-medium rounded-xl flex items-center gap-2 border border-error/30 text-sm">
            <span class="material-symbols-outlined font-bold text-lg">error</span>
            <%= error %>
        </div>
    <% } %>

    <form action="<%= ctx %>/adminLogin" method="post" class="space-y-8">
        <div class="flex flex-col space-y-2 border-b-2 border-slate-700 focus-within:border-blue-500 transition-colors">
            <label class="font-bold uppercase tracking-widest text-[10px] text-blue-400">Admin Username</label>
            <input type="text" name="username" class="w-full bg-transparent border-none p-0 focus:ring-0 text-white placeholder:text-slate-500 font-medium py-1" placeholder="Enter admin username" required autofocus>
        </div>

        <div class="flex flex-col space-y-2 border-b-2 border-slate-700 focus-within:border-blue-500 transition-colors">
            <label class="font-bold uppercase tracking-widest text-[10px] text-blue-400">Password</label>
            <input type="password" name="password" class="w-full bg-transparent border-none p-0 focus:ring-0 text-white placeholder:text-slate-500 font-medium py-1" placeholder="••••••••" required>
        </div>

        <button type="submit" class="w-full py-4 bg-blue-600 text-white font-bold rounded-xl shadow-lg hover:bg-blue-500 active:scale-[0.98] transition-all flex items-center justify-center gap-2">
            <span class="material-symbols-outlined text-lg" data-icon="login">login</span>
            Admin Sign In
        </button>
    </form>

    <div class="mt-8">
        <div class="flex justify-center mb-6">
            <a href="<%= ctx %>/" class="text-[10px] font-bold uppercase tracking-widest text-slate-500 hover:text-slate-300 transition-colors">← Back to Portal</a>
        </div>
        <div class="text-center p-3 bg-slate-800/80 rounded-lg text-xs text-slate-400 border border-slate-700/50">
            Default: <strong>admin</strong> / <strong>admin123</strong>
        </div>
    </div>
</div>
<script src="<%= ctx %>/js/main.js"></script>
</body></html>
