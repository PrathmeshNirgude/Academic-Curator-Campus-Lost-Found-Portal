<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.lostfound.model.Item, com.lostfound.model.User" %>
<%
    String ctx = request.getContextPath();
    List<Item> items = (List<Item>) request.getAttribute("items");
    User loggedUser = (User) session.getAttribute("loggedUser");
    String selectedType = (String) request.getAttribute("selectedType");
    String selectedCat = (String) request.getAttribute("selectedCategory");
    String keyword = (String) request.getAttribute("keyword");
    String success = (String) request.getAttribute("success");
    if (selectedType == null) selectedType = "";
    if (selectedCat == null) selectedCat = "";
    if (keyword == null) keyword = "";
%>
<!DOCTYPE html>
<html class="light" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Browse Items | The Academic Curator</title>
<link href="https://fonts.googleapis.com" rel="preconnect"/>
<link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "error-container": "#ffdad6",
                        "on-surface": "#191b23",
                        "inverse-surface": "#2e3039",
                        "surface-dim": "#d9d9e5",
                        "secondary": "#495c95",
                        "on-tertiary": "#ffffff",
                        "error": "#ba1a1a",
                        "surface-variant": "#e1e2ed",
                        "on-primary-fixed-variant": "#003ea8",
                        "outline": "#737686",
                        "secondary-container": "#acbfff",
                        "primary": "#004ac6",
                        "on-surface-variant": "#434655",
                        "secondary-fixed-dim": "#b4c5ff",
                        "surface-tint": "#0053db",
                        "on-secondary": "#ffffff",
                        "on-error": "#ffffff",
                        "on-tertiary-fixed": "#002113",
                        "on-secondary-container": "#394c84",
                        "on-error-container": "#93000a",
                        "surface-container-lowest": "#ffffff",
                        "tertiary-fixed-dim": "#4edea3",
                        "outline-variant": "#c3c6d7",
                        "tertiary": "#006242",
                        "surface-container": "#ededf9",
                        "surface-container-high": "#e7e7f3",
                        "primary-fixed": "#dbe1ff",
                        "on-primary-fixed": "#00174b",
                        "on-secondary-fixed-variant": "#31447b",
                        "inverse-on-surface": "#f0f0fb",
                        "on-secondary-fixed": "#00174b",
                        "on-background": "#191b23",
                        "primary-container": "#2563eb",
                        "tertiary-fixed": "#6ffbbe",
                        "on-tertiary-fixed-variant": "#005236",
                        "surface": "#faf8ff",
                        "inverse-primary": "#b4c5ff",
                        "surface-container-low": "#f3f3fe",
                        "secondary-fixed": "#dbe1ff",
                        "background": "#faf8ff",
                        "on-primary-container": "#eeefff",
                        "on-primary": "#ffffff",
                        "surface-container-highest": "#e1e2ed",
                        "surface-bright": "#faf8ff",
                        "tertiary-container": "#007d55",
                        "primary-fixed-dim": "#b4c5ff",
                        "on-tertiary-container": "#bdffdb"
                    },
                    "borderRadius": {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                    "fontFamily": {
                        "headline": ["Inter"],
                        "body": ["Inter"],
                        "label": ["Inter"]
                    }
                },
            },
        }
</script>
<style>
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; vertical-align: middle; }
</style>
</head>
<body class="bg-surface text-on-surface font-body min-h-screen flex flex-col">
<header class="bg-slate-50/80 backdrop-blur-xl dark:bg-slate-950/80 sticky top-0 z-50 shadow-sm dark:shadow-none">
<div class="flex justify-between items-center w-full px-8 py-4 max-w-7xl mx-auto">
<a href="<%= ctx %>/" class="text-2xl font-bold tracking-tighter text-blue-700 dark:text-blue-500">The Academic Curator</a>
<nav class="hidden md:flex items-center gap-8">
<a class="text-blue-600 dark:text-blue-400 border-b-2 border-blue-600 pb-1 font-semibold text-xs uppercase tracking-widest Inter transition-all duration-200 scale-[0.98]" href="<%= ctx %>/items">Browse</a>
<% if (loggedUser != null) { %>
<a class="text-slate-500 dark:text-slate-400 font-medium text-xs uppercase tracking-widest Inter hover:text-blue-500 dark:hover:text-blue-300 transition-colors" href="<%= ctx %>/reportItem">Report</a>
<a class="text-slate-500 dark:text-slate-400 font-medium text-xs uppercase tracking-widest Inter hover:text-blue-500 dark:hover:text-blue-300 transition-colors" href="<%= ctx %>/myItems">My Items</a>
<% } else { %>
<a class="text-slate-500 dark:text-slate-400 font-medium text-xs uppercase tracking-widest Inter hover:text-blue-500 dark:hover:text-blue-300 transition-colors" href="<%= ctx %>/login">Login</a>
<a class="text-slate-500 dark:text-slate-400 font-medium text-xs uppercase tracking-widest Inter hover:text-blue-500 dark:hover:text-blue-300 transition-colors" href="<%= ctx %>/register">Register</a>
<% } %>
</nav>
<div class="flex items-center gap-4">
<% if (loggedUser != null) { %>
<a href="<%= ctx %>/logout" title="Logout" class="p-2 text-on-surface-variant hover:text-error rounded-full transition-colors material-symbols-outlined" data-icon="logout">logout</a>
<% } else { %>
<a href="<%= ctx %>/login" title="Login" class="p-2 text-on-surface-variant hover:text-primary rounded-full transition-colors material-symbols-outlined" data-icon="account_circle">account_circle</a>
<% } %>
</div>
</div>
</header>

<main class="flex-grow max-w-7xl mx-auto w-full px-8 py-12">
    <% if (success != null) { %>
        <div class="mb-4 p-4 bg-tertiary-container/30 text-on-tertiary-container font-medium rounded-xl flex items-center gap-2 border border-tertiary-container">
            <span class="material-symbols-outlined font-bold">check_circle</span>
            <%= success %>
        </div>
    <% } %>

<section class="mb-16">
<div class="flex flex-col md:flex-row md:items-end justify-between gap-8">
<div class="max-w-2xl">
<h1 class="text-5xl font-extrabold tracking-tight text-on-surface mb-4">Vault of Lost Artifacts</h1>
<p class="text-on-surface-variant text-lg leading-relaxed">A curated collection of items seeking their owners. Filter by category, location, or status to begin the recovery process.</p>
</div>
</div>

<form method="get" action="<%= ctx %>/items">
<div class="mt-12 p-6 bg-surface-container-low rounded-xl flex flex-wrap items-center gap-6">
<div class="flex-grow min-w-[300px] relative">
<span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-outline" data-icon="search">search</span>
<input name="keyword" value="<%= keyword %>" class="w-full pl-12 pr-4 py-3 bg-surface-container-lowest border-none rounded-lg focus:ring-2 focus:ring-primary text-on-surface placeholder:text-outline/60 transition-all" placeholder="Search for items" type="text"/>
</div>
<div class="flex flex-wrap items-center gap-4">
<div class="flex flex-col gap-1">
<label class="font-bold uppercase tracking-widest text-[10px] text-on-surface-variant ml-1">Type</label>
<select name="type" class="bg-surface-container-lowest border-none rounded-lg text-sm font-medium py-2 px-4 focus:ring-2 focus:ring-primary">
<option value="all" <%= "all".equals(selectedType) || selectedType.isEmpty() ? "selected" : "" %>>All Types</option>
<option value="lost" <%= "lost".equals(selectedType) ? "selected" : "" %>>Lost</option>
<option value="found" <%= "found".equals(selectedType) ? "selected" : "" %>>Found</option>
</select>
</div>
<div class="flex flex-col gap-1">
<label class="font-bold uppercase tracking-widest text-[10px] text-on-surface-variant ml-1">Category</label>
<select name="category" class="bg-surface-container-lowest border-none rounded-lg text-sm font-medium py-2 px-4 focus:ring-2 focus:ring-primary">
<option value="all" <%= "all".equals(selectedCat) || selectedCat.isEmpty() ? "selected" : "" %>>All Categories</option>
<option value="Electronics" <%= "Electronics".equals(selectedCat) ? "selected" : "" %>>Electronics</option>
<option value="Books" <%= "Books".equals(selectedCat) ? "selected" : "" %>>Books</option>
<option value="ID Card" <%= "ID Card".equals(selectedCat) ? "selected" : "" %>>ID Card</option>
<option value="Clothing" <%= "Clothing".equals(selectedCat) ? "selected" : "" %>>Clothing</option>
<option value="Bags" <%= "Bags".equals(selectedCat) ? "selected" : "" %>>Bags</option>
<option value="Keys" <%= "Keys".equals(selectedCat) ? "selected" : "" %>>Keys</option>
<option value="Wallet" <%= "Wallet".equals(selectedCat) ? "selected" : "" %>>Wallet</option>
<option value="Other" <%= "Other".equals(selectedCat) ? "selected" : "" %>>Other</option>
</select>
</div>
<div class="flex items-center gap-2 mt-4 ml-2">
<button type="submit" class="bg-primary text-white px-6 py-2 rounded-lg font-bold shadow-md hover:bg-primary/90 transition-all">Search</button>
<a href="<%= ctx %>/items" class="bg-surface-container-highest text-on-surface px-6 py-2 rounded-lg font-bold hover:bg-surface-variant transition-all">Reset</a>
</div>
</div>
</div>
</form>
</section>

<% if (items == null || items.isEmpty()) { %>
   <div class="py-20 flex flex-col items-center justify-center text-center">
        <span class="material-symbols-outlined text-7xl text-outline-variant mb-4">search_off</span>
        <h3 class="text-2xl font-bold text-on-surface mb-2">No Artifacts Found</h3>
        <p class="text-on-surface-variant max-w-sm mb-8">Try adjusting your filters, or if you've lost something, log a new report.</p>
        <% if (loggedUser != null) { %>
            <a href="<%= ctx %>/reportItem" class="bg-gradient-to-br from-primary to-primary-container text-white px-8 py-3 rounded-xl font-bold shadow-lg">Report an Item</a>
        <% } %>
   </div>
<% } else { %>
    <section class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-10">
    <% for (Item item : items) { %>
        <div class="group bg-surface-container-lowest rounded-xl overflow-hidden shadow-[0px_12px_32px_rgba(25,27,35,0.04)] hover:shadow-[0px_20px_48px_rgba(25,27,35,0.08)] transition-all duration-300 flex flex-col">
            <div class="relative aspect-[4/3] overflow-hidden bg-surface-container-low flex items-center justify-center">
            <% if (item.getImagePath() != null && !item.getImagePath().isEmpty()) { %>
                <img src="<%= ctx %>/images/uploads/<%= item.getImagePath() %>" alt="<%= item.getTitle() %>" class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-105">
            <% } else { %>
                <div class="w-full h-full flex items-center justify-center bg-surface-container-high">
                    <span class="text-6xl opacity-80">
                        <% if ("Electronics".equals(item.getCategory())) { out.print("💻"); } 
                           else if ("Books".equals(item.getCategory())) { out.print("📚"); } 
                           else if ("ID Card".equals(item.getCategory())) { out.print("🪪"); }
                           else if ("Clothing".equals(item.getCategory())) { out.print("👕"); }
                           else if ("Bags".equals(item.getCategory())) { out.print("🎒"); }
                           else if ("Keys".equals(item.getCategory())) { out.print("🔑"); }
                           else if ("Wallet".equals(item.getCategory())) { out.print("👛"); }
                           else { out.print("📦"); } %>
                    </span>
                </div>
            <% } %>
                <div class="absolute top-4 left-4 <%= "lost".equals(item.getType()) ? "bg-error-container/90" : "bg-tertiary-container/90" %> backdrop-blur-md px-3 py-1 rounded-full shadow-lg">
                    <span class="text-[10px] font-bold uppercase tracking-tighter <%= "lost".equals(item.getType()) ? "text-on-error-container" : "text-on-tertiary-container" %>"><%= "lost".equals(item.getType()) ? "Lost" : "Found" %></span>
                </div>
            </div>
            
            <div class="p-6 flex flex-col flex-grow">
                <div class="flex items-center gap-2 mb-2">
                    <span class="material-symbols-outlined text-[18px] text-outline" data-icon="category">category</span>
                    <span class="font-bold uppercase tracking-widest text-[10px] text-on-surface-variant"><%= item.getCategory() %></span>
                </div>
                <h3 class="text-xl font-bold tracking-tight text-on-surface mb-4" title="<%= item.getTitle() %>"><%= item.getTitle() %></h3>
                <div class="mt-auto space-y-3">
                    <div class="flex items-center gap-3 text-sm text-on-surface-variant">
                        <span class="material-symbols-outlined text-[18px]" data-icon="location_on">location_on</span>
                        <span class="truncate"><%= item.getLocation() %></span>
                    </div>
                    <div class="flex items-center gap-3 text-sm text-on-surface-variant">
                        <span class="material-symbols-outlined text-[18px]" data-icon="calendar_today">calendar_today</span>
                        <span><%= item.getDateReported() %></span>
                    </div>
                    <div class="flex items-center gap-3 text-sm text-on-surface-variant">
                        <span class="material-symbols-outlined text-[18px]" data-icon="info">info</span>
                        <span class="font-bold <%= "open".equals(item.getStatus()) ? "text-primary" : "text-outline" %>"><%= "open".equals(item.getStatus()) ? "Open" : "Resolved" %></span>
                    </div>
                    <a href="<%= ctx %>/itemDetail?id=<%= item.getItemId() %>" class="block text-center w-full mt-6 py-3 px-6 bg-gradient-to-br from-primary to-primary-container text-white rounded-xl font-semibold text-sm transition-all active:scale-95 shadow-lg shadow-primary/20 hover:opacity-90">
                        View Details
                    </a>
                </div>
            </div>
        </div>
    <% } %>
    
    <% if (loggedUser != null) { %>
        <a href="<%= ctx %>/reportItem" class="flex flex-col items-center justify-center border-2 border-dashed border-outline-variant/30 rounded-xl p-8 group cursor-pointer hover:border-primary/50 hover:bg-surface-container-lowest transition-all h-full min-h-[300px]">
        <div class="w-16 h-16 bg-surface-container-low rounded-full flex items-center justify-center mb-4 group-hover:bg-primary-container group-hover:text-white transition-colors shadow-sm">
        <span class="material-symbols-outlined text-[32px]" data-icon="add">add</span>
        </div>
        <span class="font-bold uppercase tracking-widest text-[12px] text-on-surface">Report New Item</span>
        <p class="text-xs text-on-surface-variant mt-2 text-center max-w-[200px]">Help reunite someone with their lost property</p>
        </a>
    <% } %>
    </section>
<% } %>
</main>
<footer class="bg-white dark:bg-slate-900 w-full py-12 mt-auto border-t border-surface-container">
<div class="flex flex-col md:flex-row justify-between items-start px-12 max-w-7xl mx-auto gap-8">
<div class="max-w-sm">
<div class="text-xl font-bold text-slate-900 dark:text-slate-100 mb-4">The Academic Curator</div>
<p class="text-sm Inter text-slate-500 dark:text-slate-400">© 2026 The Academic Curator. Elevating campus lost &amp; found to a digital concierge experience.</p>
</div>
<div class="grid grid-cols-2 gap-12">
<div class="flex flex-col gap-4">
<span class="font-bold uppercase tracking-widest text-[10px] text-on-surface-variant">Policy</span>
<a class="text-sm Inter text-slate-500 dark:text-slate-400 hover:text-blue-700 dark:hover:text-blue-300 transition-opacity" href="#">Privacy Policy</a>
<a class="text-sm Inter text-slate-500 dark:text-slate-400 hover:text-blue-700 dark:hover:text-blue-300 transition-opacity" href="#">Terms of Service</a>
</div>
<div class="flex flex-col gap-4">
<span class="font-bold uppercase tracking-widest text-[10px] text-on-surface-variant">Resources</span>
<a class="text-sm Inter text-slate-500 dark:text-slate-400 hover:text-blue-700 dark:hover:text-blue-300 transition-opacity" href="<%= ctx %>/adminLogin">Admin Login</a>
<a class="text-sm Inter text-slate-500 dark:text-slate-400 hover:text-blue-700 dark:hover:text-blue-300 transition-opacity" href="#">Contact Support</a>
</div>
</div>
</div>
</footer>
</body></html>
