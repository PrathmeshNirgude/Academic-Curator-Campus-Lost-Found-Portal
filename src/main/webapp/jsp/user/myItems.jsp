<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.lostfound.model.Item, com.lostfound.model.User" %>
<%
    String ctx = request.getContextPath();
    User loggedUser = (User) session.getAttribute("loggedUser");
    List<Item> myItems = (List<Item>) request.getAttribute("myItems");
    
    int totalMine = myItems != null ? myItems.size() : 0;
    int openMine = 0, resolvedMine = 0;
    if (myItems != null) {
        for (Item it : myItems) {
            if ("open".equals(it.getStatus())) openMine++;
            else resolvedMine++;
        }
    }
%>
<!DOCTYPE html>
<html lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>My Reported Items - The Academic Curator</title>
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
                },
            },
        }
    </script>
<style>
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
        body { font-family: 'Inter', sans-serif; }
        .editorial-shadow { box-shadow: 0px 12px 32px rgba(25, 27, 35, 0.06); }
</style>
</head>
<body class="bg-surface text-on-surface min-h-screen flex flex-col">
<header class="sticky top-0 z-50 w-full bg-slate-50/80 backdrop-blur-xl dark:bg-slate-950/80 shadow-sm dark:shadow-none">
<div class="flex justify-between items-center w-full px-8 py-4 max-w-7xl mx-auto">
<div class="flex items-center gap-8">
<a href="<%= ctx %>/" class="text-2xl font-bold tracking-tighter text-blue-700 dark:text-blue-500">The Academic Curator</a>
<nav class="hidden md:flex gap-6">
<a class="text-slate-500 dark:text-slate-400 font-medium hover:text-blue-500 dark:hover:text-blue-300 transition-colors uppercase tracking-widest text-xs" href="<%= ctx %>/items">Browse</a>
<a class="text-slate-500 dark:text-slate-400 font-medium hover:text-blue-500 dark:hover:text-blue-300 transition-colors uppercase tracking-widest text-xs" href="<%= ctx %>/reportItem">Report</a>
<a class="text-blue-600 dark:text-blue-400 border-b-2 border-blue-600 pb-1 font-semibold uppercase tracking-widest text-xs" href="<%= ctx %>/myItems">My Items</a>
</nav>
</div>
<div class="flex items-center gap-4">
<a href="<%= ctx %>/logout" title="Logout" class="material-symbols-outlined text-on-surface-variant hover:text-error transition-colors p-2" data-icon="logout">logout</a>
</div>
</div>
</header>

<main class="flex-grow w-full max-w-7xl mx-auto px-8 py-12">
<header class="mb-12 flex flex-col md:flex-row md:items-end justify-between gap-6">
<div>
<h1 class="text-4xl font-extrabold tracking-tight mb-2 text-on-surface">Curated Inventory</h1>
<p class="text-on-surface-variant text-lg">Welcome, <strong><%= loggedUser.getName() %></strong> — manage your reported artifacts and lost possessions across campus.</p>
</div>
<a href="<%= ctx %>/reportItem" class="bg-gradient-to-br from-primary to-primary-container text-white px-8 py-3 rounded-xl font-bold shadow-lg hover:brightness-105 transition-all text-center">Report New Item</a>
</header>

<section class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-16">
<div class="bg-surface-container-low p-8 rounded-xl flex flex-col justify-between border-b-2 border-primary/10">
<span class="text-[10px] font-bold uppercase tracking-[0.2em] text-on-surface-variant mb-4">Total Reported</span>
<div class="flex items-baseline gap-2">
<span class="text-5xl font-black tracking-tighter"><%= String.format("%02d", totalMine) %></span>
<span class="material-symbols-outlined text-primary" data-icon="archive">archive</span>
</div>
</div>
<div class="bg-primary-container/10 p-8 rounded-xl flex flex-col justify-between border-b-2 border-primary/20">
<span class="text-[10px] font-bold uppercase tracking-[0.2em] text-primary mb-4">Open Items</span>
<div class="flex items-baseline gap-2">
<span class="text-5xl font-black tracking-tighter text-primary"><%= String.format("%02d", openMine) %></span>
<span class="material-symbols-outlined text-primary" data-icon="pending_actions">pending_actions</span>
</div>
</div>
<div class="bg-tertiary-container/10 p-8 rounded-xl flex flex-col justify-between border-b-2 border-tertiary/20">
<span class="text-[10px] font-bold uppercase tracking-[0.2em] text-tertiary mb-4">Resolved</span>
<div class="flex items-baseline gap-2">
<span class="text-5xl font-black tracking-tighter text-tertiary"><%= String.format("%02d", resolvedMine) %></span>
<span class="material-symbols-outlined text-tertiary" data-icon="verified">verified</span>
</div>
</div>
</section>

<% if (myItems == null || myItems.isEmpty()) { %>
   <div class="py-20 flex flex-col items-center justify-center text-center">
        <span class="material-symbols-outlined text-7xl text-outline-variant mb-4">archive</span>
        <h3 class="text-2xl font-bold text-on-surface mb-2">No Artifacts Reported</h3>
        <p class="text-on-surface-variant max-w-sm mb-8">You haven't reported any lost or found items yet.</p>
        <a href="<%= ctx %>/reportItem" class="bg-gradient-to-br from-primary to-primary-container text-white px-8 py-3 rounded-xl font-bold shadow-lg text-sm">Create First Report</a>
   </div>
<% } else { %>
<section class="bg-surface-container-low rounded-xl overflow-hidden editorial-shadow">
<div class="px-8 py-6 flex justify-between items-center bg-surface-container-high/50 max-md:flex-col max-md:gap-4 max-md:items-start">
<h2 class="font-bold text-sm uppercase tracking-widest">Active Records</h2>
<div class="flex gap-2">
<button class="bg-surface-container-lowest px-4 py-2 rounded-full text-xs font-bold border border-outline-variant/20">ALL</button>
</div>
</div>
<div class="overflow-x-auto">
<table class="w-full text-left border-collapse">
<thead>
<tr class="text-[10px] uppercase tracking-[0.15em] text-on-surface-variant border-b border-outline-variant/10">
<th class="px-8 py-4 font-bold min-w-[250px]">Artifact</th>
<th class="px-8 py-4 font-bold text-center">Type</th>
<th class="px-8 py-4 font-bold">Category</th>
<th class="px-8 py-4 font-bold">Status</th>
<th class="px-8 py-4 font-bold text-right min-w-[120px]">Actions</th>
</tr>
</thead>
<tbody class="divide-y divide-outline-variant/10">
<% for (Item item : myItems) { %>
<tr class="hover:bg-surface-container-lowest/50 transition-colors">
<td class="px-8 py-6">
<div class="flex items-center gap-4">
<div class="w-12 h-12 rounded-lg overflow-hidden bg-surface-variant flex items-center justify-center shrink-0">
   <% if (item.getImagePath() != null && !item.getImagePath().isEmpty()) { %>
       <img src="<%= ctx %>/images/uploads/<%= item.getImagePath() %>" alt="<%= item.getTitle() %>" class="w-full h-full object-cover">
   <% } else { %>
       <span class="text-2xl opacity-50">
           <% if ("Electronics".equals(item.getCategory())) { out.print("💻"); } 
              else if ("Books".equals(item.getCategory())) { out.print("📚"); } 
              else if ("ID Card".equals(item.getCategory())) { out.print("🪪"); }
              else if ("Clothing".equals(item.getCategory())) { out.print("👕"); }
              else if ("Bags".equals(item.getCategory())) { out.print("🎒"); }
              else if ("Keys".equals(item.getCategory())) { out.print("🔑"); }
              else if ("Wallet".equals(item.getCategory())) { out.print("👛"); }
              else { out.print("📦"); } %>
       </span>
   <% } %>
</div>
<div>
<div class="font-bold text-on-surface tracking-tight" title="<%= item.getTitle() %>"><%= item.getTitle() %></div>
<div class="text-xs text-on-surface-variant mt-1">Reported: <%= item.getDateReported() %></div>
<div class="text-xs text-on-surface-variant flex items-center gap-1 mt-1 truncate max-w-[200px]">
    <span class="material-symbols-outlined text-[12px]">location_on</span> <%= item.getLocation() %>
</div>
</div>
</div>
</td>
<td class="px-8 py-6 text-center">
<% if ("lost".equals(item.getType())) { %>
<span class="bg-error-container/80 text-on-error-container px-3 py-1 rounded-full text-[10px] font-bold uppercase tracking-wider">Lost</span>
<% } else { %>
<span class="bg-tertiary-container/80 text-on-tertiary-container px-3 py-1 rounded-full text-[10px] font-bold uppercase tracking-wider">Found</span>
<% } %>
</td>
<td class="px-8 py-6">
<span class="bg-secondary-container/30 text-on-secondary-container px-3 py-1 rounded-full text-[10px] font-bold uppercase tracking-wider"><%= item.getCategory() %></span>
</td>
<td class="px-8 py-6">
<% if ("open".equals(item.getStatus())) { %>
<div class="flex items-center gap-2 text-error font-semibold text-xs italic">
<span class="w-2 h-2 rounded-full bg-error animate-pulse"></span> Open
</div>
<% } else { %>
<div class="flex items-center gap-2 text-tertiary font-semibold text-xs italic">
<span class="w-2 h-2 rounded-full bg-tertiary"></span> Resolved
</div>
<% } %>
</td>
<td class="px-8 py-6 text-right">
<div class="flex justify-end gap-2">
<a href="<%= ctx %>/itemDetail?id=<%= item.getItemId() %>" class="text-primary hover:bg-primary/10 p-2 rounded-lg transition-all" title="View Details">
<span class="material-symbols-outlined text-lg" data-icon="visibility">visibility</span>
</a>
<button onclick="confirmDelete('<%= ctx %>/deleteItem?id=<%= item.getItemId() %>','<%= item.getTitle().replace("'","") %>')" class="text-on-surface-variant hover:text-error hover:bg-error/10 p-2 rounded-lg transition-all" title="Delete Record">
<span class="material-symbols-outlined text-lg" data-icon="delete">delete</span>
</button>
</div>
</td>
</tr>
<% } %>
</tbody>
</table>
</div>
</section>
<% } %>
</main>
<footer class="bg-white dark:bg-slate-900 w-full py-12 mt-auto border-t border-surface-container">
<div class="flex flex-col md:flex-row justify-between items-start px-12 max-w-7xl mx-auto gap-8">
<div class="max-w-xs">
<span class="text-xl font-bold text-slate-900 dark:text-slate-100 mb-4 block">The Academic Curator</span>
<p class="text-sm Inter text-slate-500 dark:text-slate-400">© 2026 The Academic Curator. Elevating campus lost &amp; found to a digital concierge experience.</p>
</div>
<div class="flex flex-wrap gap-x-12 gap-y-4">
<div class="flex flex-col gap-2">
<span class="font-bold uppercase tracking-widest text-[10px] text-on-surface-variant">Resources</span>
<a class="text-slate-500 dark:text-slate-400 hover:text-blue-700 dark:hover:text-blue-300 text-sm transition-colors" href="#">Privacy Policy</a>
<a class="text-slate-500 dark:text-slate-400 hover:text-blue-700 dark:hover:text-blue-300 text-sm transition-colors" href="#">Campus Safety</a>
</div>
<div class="flex flex-col gap-2">
<span class="font-bold uppercase tracking-widest text-[10px] text-on-surface-variant">Help Desk</span>
<a class="text-slate-500 dark:text-slate-400 hover:text-blue-700 dark:hover:text-blue-300 text-sm transition-colors" href="<%= ctx %>/adminLogin">Admin Login</a>
<a class="text-slate-500 dark:text-slate-400 hover:text-blue-700 dark:hover:text-blue-300 text-sm transition-colors" href="#">Contact Support</a>
</div>
</div>
</div>
</footer>
<script>
function confirmDelete(url, title) {
    if(confirm("Are you sure you want to delete the report for '" + title + "'?\nThis action cannot be undone.")) {
        window.location.href = url;
    }
}
</script>
</body></html>
