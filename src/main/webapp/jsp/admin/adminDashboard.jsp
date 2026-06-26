<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.lostfound.model.Item, com.lostfound.model.Claim" %>
<%
    String ctx = request.getContextPath();
    String adminUsername = (String) session.getAttribute("adminUsername");
    if (adminUsername == null) adminUsername = "Admin";
    Integer totalItems = (Integer) request.getAttribute("totalItems");
    Integer openItems = (Integer) request.getAttribute("openItems");
    Integer resolvedItems = (Integer) request.getAttribute("resolvedItems");
    Integer lostItems = (Integer) request.getAttribute("lostItems");
    Integer foundItems = (Integer) request.getAttribute("foundItems");
    Integer pendingClaims = (Integer) request.getAttribute("pendingClaims");
    Integer totalClaims = (Integer) request.getAttribute("totalClaims");
    List<Claim> allClaims = (List<Claim>) request.getAttribute("allClaims");
    List<Item> allItems = (List<Item>) request.getAttribute("allItems");
    if (totalItems == null) totalItems = 0;
    if (openItems == null) openItems = 0;
    if (resolvedItems == null) resolvedItems = 0;
    if (lostItems == null) lostItems = 0;
    if (foundItems == null) foundItems = 0;
    if (pendingClaims == null) pendingClaims = 0;
    if (totalClaims == null) totalClaims = 0;
%>
<!DOCTYPE html>
<html class="light" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Academic Curator | Campus Beacon Admin</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script id="tailwind-config">
      tailwind.config = {
        darkMode: "class",
        theme: {
          extend: {
            "colors": {
                    "surface-bright": "#faf8ff",
                    "inverse-on-surface": "#f0f0fb",
                    "surface": "#faf8ff",
                    "outline-variant": "#c3c6d7",
                    "on-tertiary-fixed-variant": "#005236",
                    "on-error": "#ffffff",
                    "surface-container-low": "#f3f3fe",
                    "on-secondary-container": "#394c84",
                    "surface-container-high": "#e7e7f3",
                    "on-background": "#191b23",
                    "surface-variant": "#e1e2ed",
                    "secondary-fixed-dim": "#b4c5ff",
                    "primary-container": "#2563eb",
                    "on-tertiary": "#ffffff",
                    "surface-container": "#ededf9",
                    "primary-fixed-dim": "#b4c5ff",
                    "secondary-fixed": "#dbe1ff",
                    "on-surface-variant": "#434655",
                    "on-tertiary-fixed": "#002113",
                    "inverse-primary": "#b4c5ff",
                    "surface-tint": "#0053db",
                    "tertiary-fixed": "#6ffbbe",
                    "on-secondary": "#ffffff",
                    "secondary-container": "#acbfff",
                    "outline": "#737686",
                    "background": "#faf8ff",
                    "surface-container-lowest": "#ffffff",
                    "on-primary-container": "#eeefff",
                    "on-primary-fixed-variant": "#003ea8",
                    "on-primary-fixed": "#00174b",
                    "primary-fixed": "#dbe1ff",
                    "error-container": "#ffdad6",
                    "on-secondary-fixed": "#00174b",
                    "tertiary-container": "#007d55",
                    "secondary": "#495c95",
                    "inverse-surface": "#2e3039",
                    "surface-dim": "#d9d9e5",
                    "on-secondary-fixed-variant": "#31447b",
                    "tertiary-fixed-dim": "#4edea3",
                    "on-primary": "#ffffff",
                    "error": "#ba1a1a",
                    "tertiary": "#006242",
                    "on-error-container": "#93000a",
                    "on-tertiary-container": "#bdffdb",
                    "on-surface": "#191b23",
                    "surface-container-highest": "#e1e2ed",
                    "primary": "#004ac6"
            },
          },
        },
      }
    </script>
<style>
        body { font-family: 'Inter', sans-serif; }
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
        .admin-tab { display: none; }
        .admin-tab.active { display: block; }
</style>
</head>
<body class="bg-surface text-on-background">

<!-- SideNavBar -->
<aside class="h-screen w-64 fixed left-0 top-0 bg-slate-50 dark:bg-slate-900 shadow-[12px_0_32px_rgba(25,27,35,0.04)] flex flex-col p-4 gap-2 z-50">
<div class="px-4 py-6">
<h1 class="text-lg font-black tracking-tighter text-blue-700 dark:text-blue-300">Academic Curator</h1>
<p class="font-inter tracking-tight text-sm font-medium text-slate-500">Admin Portal</p>
</div>
<nav class="flex flex-col gap-1">
<a id="nav-overview" onclick="switchTabAdmin('overview')" class="cursor-pointer flex items-center gap-3 px-4 py-3 bg-white dark:bg-slate-800 text-blue-700 dark:text-blue-300 shadow-sm rounded-lg font-bold transition-colors nav-link-item">
<span class="material-symbols-outlined" data-icon="dashboard">dashboard</span>
<span class="font-inter tracking-tight text-sm font-medium">Dashboard</span>
</a>
<a id="nav-claims" onclick="switchTabAdmin('claims')" class="cursor-pointer flex items-center gap-3 px-4 py-3 text-slate-500 dark:text-slate-400 hover:text-slate-900 dark:hover:text-slate-100 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors rounded-lg nav-link-item">
<span class="material-symbols-outlined" data-icon="assignment_turned_in">assignment_turned_in</span>
<span class="font-inter tracking-tight text-sm font-medium">Claims</span>
<% if (pendingClaims > 0) { %><span class="ml-auto bg-error text-white text-[10px] font-bold px-2 py-0.5 rounded-full"><%= pendingClaims %></span><% } %>
</a>
<a id="nav-items" onclick="switchTabAdmin('items')" class="cursor-pointer flex items-center gap-3 px-4 py-3 text-slate-500 dark:text-slate-400 hover:text-slate-900 dark:hover:text-slate-100 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors rounded-lg nav-link-item">
<span class="material-symbols-outlined" data-icon="inventory_2">inventory_2</span>
<span class="font-inter tracking-tight text-sm font-medium">All Items</span>
</a>
<a onclick="document.getElementById('reportModal').classList.remove('hidden')" class="cursor-pointer flex items-center gap-3 px-4 py-3 text-slate-500 dark:text-slate-400 hover:text-slate-900 dark:hover:text-slate-100 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors rounded-lg nav-link-item">
<span class="material-symbols-outlined" data-icon="download">download</span>
<span class="font-inter tracking-tight text-sm font-medium">Download Report</span>
</a>
<a href="<%= ctx %>/" target="_blank" class="flex items-center gap-3 px-4 py-3 text-slate-500 dark:text-slate-400 hover:text-slate-900 dark:hover:text-slate-100 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors rounded-lg mt-4 border-t border-slate-200 dark:border-slate-700 pt-4">
<span class="material-symbols-outlined" data-icon="public">public</span>
<span class="font-inter tracking-tight text-sm font-medium">View Portal</span>
</a>
<a href="<%= ctx %>/logout" class="flex items-center gap-3 px-4 py-3 text-error hover:bg-error-container/20 transition-colors rounded-lg">
<span class="material-symbols-outlined" data-icon="logout">logout</span>
<span class="font-inter tracking-tight text-sm font-medium">Logout</span>
</a>
</nav>
<div class="mt-auto p-4 flex items-center gap-3">
<div class="w-10 h-10 rounded-full bg-primary-container text-primary flex items-center justify-center font-bold text-lg"><%= adminUsername.substring(0, 1).toUpperCase() %></div>
<div>
<p class="text-xs font-bold text-on-surface"><%= adminUsername %></p>
<p class="text-[10px] text-on-surface-variant uppercase tracking-wider">Super Admin</p>
</div>
</div>
</aside>

<!-- TopNavBar -->
<header class="fixed top-0 right-0 w-[calc(100%-16rem)] h-16 z-40 bg-white/80 dark:bg-slate-950/80 backdrop-blur-xl border-b border-surface-container-low flex items-center justify-between px-8">
<div class="flex items-center gap-4">
<span class="text-xl font-bold tracking-tighter text-blue-800 dark:text-blue-200">Campus Beacon</span>
</div>
<div class="flex items-center gap-6">
<div class="relative w-64">
<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-sm" data-icon="search">search</span>
<input class="w-full bg-surface-container-low border-none rounded-full py-1.5 pl-10 pr-4 text-xs focus:ring-1 focus:ring-primary/20 placeholder:text-slate-400" placeholder="Search curated items..." type="text"/>
</div>
</div>
</header>

<!-- Main Content Area -->
<main class="ml-64 pt-16 min-h-screen bg-surface-container-low">
<div class="max-w-7xl mx-auto px-8 py-10">

<!-- ===== OVERVIEW TAB ===== -->
<div id="tab-overview" class="admin-tab active">
    <!-- Page Header -->
    <div class="mb-10 flex items-end justify-between">
    <div>
    <span class="text-[10px] font-bold tracking-[0.2em] text-primary uppercase mb-2 block">Executive Overview</span>
    <h2 class="text-4xl font-black tracking-tight text-on-surface">Curator's Dashboard</h2>
    </div>
    <button onclick="document.getElementById('reportModal').classList.remove('hidden')"
        class="flex items-center gap-2 bg-primary text-white px-5 py-2.5 rounded-xl text-sm font-semibold shadow-lg shadow-primary/20 hover:scale-[1.02] active:scale-95 transition-all">
        <span class="material-symbols-outlined text-lg">download</span>
        Download Report
    </button>
    </div>

    <!-- Alert Bar -->
    <% if (pendingClaims > 0) { %>
    <div class="mb-10 bg-primary-container text-on-primary-container p-4 rounded-xl flex items-center justify-between shadow-sm">
    <div class="flex items-center gap-3">
    <span class="material-symbols-outlined bg-white/20 p-1.5 rounded-lg text-lg" data-icon="notification_important">notification_important</span>
    <p class="font-medium text-sm"><%= pendingClaims %> pending claim(s) awaiting review</p>
    </div>
    <a class="text-xs font-bold uppercase tracking-widest bg-white/10 px-4 py-2 rounded-lg hover:bg-white/20 transition-colors cursor-pointer" onclick="switchTabAdmin('claims')">Review Now</a>
    </div>
    <% } else { %>
    <div class="mb-10 bg-tertiary-container/30 text-on-tertiary-container p-4 rounded-xl flex items-center gap-3 border border-tertiary-container shadow-sm">
        <span class="material-symbols-outlined font-bold">check_circle</span>
        <p class="font-medium text-sm">All claims have been reviewed. No pending actions.</p>
    </div>
    <% } %>

    <!-- Metric Bento Grid -->
    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-6 mb-12">
    <!-- Total Items -->
    <div class="bg-surface-container-lowest p-6 rounded-xl shadow-[0_12px_32px_rgba(25,27,35,0.04)] relative overflow-hidden group">
    <div class="relative z-10">
    <span class="text-[10px] font-bold tracking-widest text-on-surface-variant uppercase">Total Items</span>
    <div class="text-4xl font-black text-on-surface mt-2"><%= totalItems %></div>
    </div>
    <span class="material-symbols-outlined absolute -right-4 -bottom-4 text-7xl text-surface-container-high opacity-50 group-hover:scale-110 transition-transform" data-icon="inventory">inventory</span>
    </div>
    <!-- Lost Items -->
    <div class="bg-surface-container-lowest p-6 rounded-xl shadow-[0_12px_32px_rgba(25,27,35,0.04)] relative overflow-hidden group">
    <div class="relative z-10">
    <span class="text-[10px] font-bold tracking-widest text-on-surface-variant uppercase">Lost Items</span>
    <div class="text-4xl font-black text-error mt-2"><%= lostItems %></div>
    </div>
    <span class="material-symbols-outlined absolute -right-4 -bottom-4 text-7xl text-error-container opacity-30 group-hover:scale-110 transition-transform" data-icon="location_searching">location_searching</span>
    </div>
    <!-- Found Items -->
    <div class="bg-surface-container-lowest p-6 rounded-xl shadow-[0_12px_32px_rgba(25,27,35,0.04)] relative overflow-hidden group">
    <div class="relative z-10">
    <span class="text-[10px] font-bold tracking-widest text-on-surface-variant uppercase">Found Items</span>
    <div class="text-4xl font-black text-tertiary mt-2"><%= foundItems %></div>
    </div>
    <span class="material-symbols-outlined absolute -right-4 -bottom-4 text-7xl text-tertiary-container opacity-20 group-hover:scale-110 transition-transform" data-icon="verified">verified</span>
    </div>
    <!-- Resolved -->
    <div class="bg-surface-container-lowest p-6 rounded-xl shadow-[0_12px_32px_rgba(25,27,35,0.04)] relative overflow-hidden group">
    <div class="relative z-10">
    <span class="text-[10px] font-bold tracking-widest text-on-surface-variant uppercase">Resolved Items</span>
    <div class="text-4xl font-black text-slate-500 mt-2"><%= resolvedItems %></div>
    </div>
    <span class="material-symbols-outlined absolute -right-4 -bottom-4 text-7xl text-surface-container-high opacity-50 group-hover:scale-110 transition-transform" data-icon="check_circle">check_circle</span>
    </div>
    </div>

    <!-- Recent Items Editorial Table -->
    <section class="bg-surface-container-lowest rounded-xl shadow-[0_12px_32px_rgba(25,27,35,0.06)] overflow-hidden">
    <div class="p-6 border-b border-surface-container-low flex justify-between items-center">
    <h3 class="text-lg font-bold text-on-surface tracking-tight">Recent Artifacts</h3>
    <div class="flex gap-2">
    <button onclick="switchTabAdmin('items')" class="text-xs font-bold text-primary hover:underline transition-colors uppercase tracking-widest">
        View All Items
    </button>
    </div>
    </div>
    <div class="overflow-x-auto">
    <table class="w-full text-left">
    <thead>
    <tr class="bg-surface-container/30">
    <th class="px-6 py-4 text-[10px] font-bold text-on-surface-variant uppercase tracking-widest">Title</th>
    <th class="px-6 py-4 text-[10px] font-bold text-on-surface-variant uppercase tracking-widest">Type</th>
    <th class="px-6 py-4 text-[10px] font-bold text-on-surface-variant uppercase tracking-widest">Category</th>
    <th class="px-6 py-4 text-[10px] font-bold text-on-surface-variant uppercase tracking-widest">Location</th>
    <th class="px-6 py-4 text-[10px] font-bold text-on-surface-variant uppercase tracking-widest">Status</th>
    <th class="px-6 py-4 text-[10px] font-bold text-on-surface-variant uppercase tracking-widest text-right">Actions</th>
    </tr>
    </thead>
    <tbody class="divide-y divide-surface-container-low">
    <%
        int count = 0;
        if (allItems != null) {
            for (Item item : allItems) {
                if (count >= 5) break;
                count++;
    %>
    <tr class="hover:bg-surface-container-low/50 transition-colors">
    <td class="px-6 py-5">
    <div class="flex items-center gap-3">
    <div class="w-10 h-10 rounded-lg bg-surface-container overflow-hidden shrink-0 flex items-center justify-center">
        <% if (item.getImagePath() != null && !item.getImagePath().isEmpty()) { %>
           <img src="<%= ctx %>/images/uploads/<%= item.getImagePath() %>" alt="<%= item.getTitle() %>" class="w-full h-full object-cover">
        <% } else { %>
           <span class="text-xl opacity-50">
               <% if ("Electronics".equals(item.getCategory())) { out.print("💻"); } 
                  else if ("Books".equals(item.getCategory())) { out.print("📚"); } 
                  else { out.print("📦"); } %>
           </span>
        <% } %>
    </div>
    <div>
        <span class="text-sm font-bold text-on-surface"><%= item.getTitle() %></span>
        <div class="text-[10px] text-on-surface-variant uppercase mt-1">by <%= item.getReporterName() %></div>
    </div>
    </div>
    </td>
    <td class="px-6 py-5">
    <% if ("lost".equals(item.getType())) { %>
    <span class="px-3 py-1 bg-error-container text-on-error-container text-[10px] font-black rounded-full uppercase">Lost</span>
    <% } else { %>
    <span class="px-3 py-1 bg-tertiary-container text-on-tertiary-container text-[10px] font-black rounded-full uppercase">Found</span>
    <% } %>
    </td>
    <td class="px-6 py-5">
    <span class="text-xs text-on-secondary-container bg-secondary-container/30 px-2 py-1 rounded-md"><%= item.getCategory() %></span>
    </td>
    <td class="px-6 py-5">
    <div class="flex items-center gap-1.5 text-on-surface-variant text-xs">
    <span class="material-symbols-outlined text-sm" data-icon="location_on">location_on</span> <%= item.getLocation() %>
    </div>
    </td>
    <td class="px-6 py-5">
    <% if ("open".equals(item.getStatus())) { %>
    <span class="flex items-center gap-1.5 text-[10px] font-bold uppercase tracking-wider text-primary">
    <span class="w-1.5 h-1.5 rounded-full bg-primary animate-pulse"></span> Open
    </span>
    <% } else { %>
    <span class="flex items-center gap-1.5 text-[10px] font-bold uppercase tracking-wider text-tertiary">
    <span class="w-1.5 h-1.5 rounded-full bg-tertiary"></span> Resolved
    </span>
    <% } %>
    </td>
    <td class="px-6 py-5 text-right">
    <div class="flex justify-end gap-2">
    <a href="<%= ctx %>/itemDetail?id=<%= item.getItemId() %>" target="_blank" class="p-2 text-primary hover:bg-primary-container/20 rounded-lg transition-all" title="View Detail">
    <span class="material-symbols-outlined text-lg" data-icon="visibility">visibility</span>
    </a>
    <a href="<%= ctx %>/deleteItem?id=<%= item.getItemId() %>" onclick="return confirm('Delete this item?')" class="p-2 text-error hover:bg-error-container/20 rounded-lg transition-all" title="Delete Artifact">
    <span class="material-symbols-outlined text-lg" data-icon="delete">delete</span>
    </a>
    </div>
    </td>
    </tr>
    <% } } %>
    </tbody>
    </table>
    </div>
    </section>
</div>

<!-- ===== CLAIMS TAB ===== -->
<div id="tab-claims" class="admin-tab">
    <div class="mb-10 flex items-end justify-between">
    <div>
    <span class="text-[10px] font-bold tracking-[0.2em] text-primary uppercase mb-2 block">Resolution Center</span>
    <h2 class="text-4xl font-black tracking-tight text-on-surface">Claims Management</h2>
    </div>
    </div>
    
    <% if (allClaims == null || allClaims.isEmpty()) { %>
    <div class="bg-surface-container-lowest rounded-xl shadow-sm p-20 flex flex-col items-center justify-center text-center">
        <span class="material-symbols-outlined text-7xl text-surface-variant mb-4">assignment_turned_in</span>
        <h3 class="text-2xl font-bold text-on-surface mb-2">No Claims Yet</h3>
        <p class="text-on-surface-variant">No ownership claims have been submitted yet.</p>
    </div>
    <% } else { %>
    <section class="bg-surface-container-lowest rounded-xl shadow-[0_12px_32px_rgba(25,27,35,0.06)] overflow-hidden">
    <div class="overflow-x-auto">
    <table class="w-full text-left">
    <thead>
    <tr class="bg-surface-container/30 border-b border-outline-variant/10">
    <th class="px-6 py-4 text-[10px] font-bold text-on-surface-variant uppercase tracking-widest">Item / Type</th>
    <th class="px-6 py-4 text-[10px] font-bold text-on-surface-variant uppercase tracking-widest">Claimant Details</th>
    <th class="px-6 py-4 text-[10px] font-bold text-on-surface-variant uppercase tracking-widest">Proof Description</th>
    <th class="px-6 py-4 text-[10px] font-bold text-on-surface-variant uppercase tracking-widest">Date</th>
    <th class="px-6 py-4 text-[10px] font-bold text-on-surface-variant uppercase tracking-widest border-l border-outline-variant/10">Status / Action</th>
    </tr>
    </thead>
    <tbody class="divide-y divide-surface-container-low">
    <% for (Claim c : allClaims) { %>
    <tr class="hover:bg-surface-container-low/50 transition-colors <%= "pending".equals(c.getStatus()) ? "bg-primary-container/5" : "" %>">
    <td class="px-6 py-5 align-top">
        <div class="font-bold text-on-surface mb-1"><%= c.getItemTitle() %></div>
        <span class="px-2 py-0.5 <%= "lost".equals(c.getItemType()) ? "bg-error-container text-on-error-container" : "bg-tertiary-container text-on-tertiary-container" %> text-[9px] font-black rounded uppercase"><%= c.getItemType() %></span>
    </td>
    <td class="px-6 py-5 align-top">
        <div class="font-bold text-sm text-on-surface"><%= c.getClaimantName() %></div>
        <div class="text-xs text-on-surface-variant mt-1"><%= c.getClaimantEmail() %></div>
        <% if(c.getClaimantPhone() != null && !c.getClaimantPhone().isEmpty()) { %>
        <div class="text-xs text-on-surface-variant"><%= c.getClaimantPhone() %></div>
        <% } %>
    </td>
    <td class="px-6 py-5 align-top max-w-[250px]">
        <p class="text-sm text-on-surface-variant bg-surface-container/30 p-3 rounded-lg"><%= c.getProofDescription() %></p>
    </td>
    <td class="px-6 py-5 align-top">
        <div class="text-xs text-on-surface font-medium whitespace-nowrap"><%= c.getClaimedAt() != null ? c.getClaimedAt().toString().substring(0,10) : "" %></div>
    </td>
    <td class="px-6 py-5 align-top border-l border-outline-variant/10 text-right">
        <div class="flex flex-col items-end gap-2">
            <% if ("pending".equals(c.getStatus())) { %>
                <span class="px-2 py-1 bg-surface-variant text-on-surface-variant text-[10px] font-bold rounded-md uppercase tracking-wider mb-2">Pending</span>
                <div class="flex gap-2">
                    <a href="<%= ctx %>/adminClaim?action=approve&claimId=<%= c.getClaimId() %>&itemId=<%= c.getItemId() %>" onclick="return confirm('Approve this claim? The item will be marked resolved.')" class="bg-tertiary text-white px-3 py-1.5 rounded-lg text-xs font-bold hover:bg-tertiary/90 transition-all flex items-center gap-1 shadow-sm">
                        <span class="material-symbols-outlined text-[14px]">check</span> Approve
                    </a>
                    <a href="<%= ctx %>/adminClaim?action=reject&claimId=<%= c.getClaimId() %>&itemId=<%= c.getItemId() %>" onclick="return confirm('Reject this claim?')" class="bg-surface-container-highest text-error px-3 py-1.5 rounded-lg text-xs font-bold hover:bg-error-container transition-all flex items-center gap-1">
                        <span class="material-symbols-outlined text-[14px]">close</span> Reject
                    </a>
                </div>
            <% } else { %>
                <span class="px-3 py-1 <%= "approved".equals(c.getStatus()) ? "bg-tertiary-container text-on-tertiary-container" : "bg-error-container text-on-error-container" %> text-[10px] font-bold rounded-full uppercase tracking-wider">
                    <%= c.getStatus() %>
                </span>
            <% } %>
        </div>
    </td>
    </tr>
    <% } %>
    </tbody>
    </table>
    </div>
    </section>
    <% } %>
</div>

<!-- ===== ALL ITEMS TAB ===== -->
<div id="tab-items" class="admin-tab">
    <div class="mb-10 flex items-end justify-between">
    <div>
    <span class="text-[10px] font-bold tracking-[0.2em] text-primary uppercase mb-2 block">Comprehensive Log</span>
    <h2 class="text-4xl font-black tracking-tight text-on-surface">All Items Overview</h2>
    </div>
    <div class="flex gap-2">
    <a href="<%= ctx %>/reportItem" target="_blank" class="bg-primary text-white px-5 py-2.5 rounded-xl text-sm font-semibold shadow-lg shadow-primary/20 hover:scale-[1.02] active:scale-95 transition-all flex items-center gap-2">
        <span class="material-symbols-outlined text-lg" data-icon="add">add</span> Post Item
    </a>
    </div>
    </div>
    
    <% if (allItems == null || allItems.isEmpty()) { %>
    <div class="bg-surface-container-lowest rounded-xl shadow-sm p-20 flex flex-col items-center justify-center text-center">
        <span class="material-symbols-outlined text-7xl text-surface-variant mb-4">inventory_2</span>
        <h3 class="text-2xl font-bold text-on-surface mb-2">No Items Found</h3>
        <p class="text-on-surface-variant">The portal currently has no reported items.</p>
    </div>
    <% } else { %>
    <section class="bg-surface-container-lowest rounded-xl shadow-[0_12px_32px_rgba(25,27,35,0.06)] overflow-hidden">
    <div class="overflow-x-auto">
    <table class="w-full text-left">
    <thead>
    <tr class="bg-surface-container/30">
    <th class="px-6 py-4 text-[10px] font-bold text-on-surface-variant uppercase tracking-widest">Title</th>
    <th class="px-6 py-4 text-[10px] font-bold text-on-surface-variant uppercase tracking-widest">Type</th>
    <th class="px-6 py-4 text-[10px] font-bold text-on-surface-variant uppercase tracking-widest">Category</th>
    <th class="px-6 py-4 text-[10px] font-bold text-on-surface-variant uppercase tracking-widest">Location</th>
    <th class="px-6 py-4 text-[10px] font-bold text-on-surface-variant uppercase tracking-widest">Status / Date</th>
    <th class="px-6 py-4 text-[10px] font-bold text-on-surface-variant uppercase tracking-widest text-right">Actions</th>
    </tr>
    </thead>
    <tbody class="divide-y divide-surface-container-low">
    <% for (Item item : allItems) { %>
    <tr class="hover:bg-surface-container-low/50 transition-colors">
    <td class="px-6 py-5">
    <div class="flex items-center gap-3">
    <div class="w-10 h-10 rounded-lg bg-surface-container overflow-hidden shrink-0 flex items-center justify-center">
        <% if (item.getImagePath() != null && !item.getImagePath().isEmpty()) { %>
           <img src="<%= ctx %>/images/uploads/<%= item.getImagePath() %>" alt="<%= item.getTitle() %>" class="w-full h-full object-cover">
        <% } else { %>
           <span class="text-xl opacity-50">
               <% if ("Electronics".equals(item.getCategory())) { out.print("💻"); } 
                  else if ("Books".equals(item.getCategory())) { out.print("📚"); } 
                  else { out.print("📦"); } %>
           </span>
        <% } %>
    </div>
    <div>
        <span class="text-sm font-bold text-on-surface"><%= item.getTitle() %></span>
        <div class="text-[10px] text-on-surface-variant uppercase mt-1">by <%= item.getReporterName() %></div>
    </div>
    </div>
    </td>
    <td class="px-6 py-5">
    <% if ("lost".equals(item.getType())) { %>
    <span class="px-3 py-1 bg-error-container text-on-error-container text-[10px] font-black rounded-full uppercase">Lost</span>
    <% } else { %>
    <span class="px-3 py-1 bg-tertiary-container text-on-tertiary-container text-[10px] font-black rounded-full uppercase">Found</span>
    <% } %>
    </td>
    <td class="px-6 py-5">
    <span class="text-xs text-on-secondary-container bg-secondary-container/30 px-2 py-1 rounded-md"><%= item.getCategory() %></span>
    </td>
    <td class="px-6 py-5">
    <div class="flex items-center gap-1.5 text-on-surface-variant text-xs truncate max-w-[150px]">
    <span class="material-symbols-outlined text-sm" data-icon="location_on">location_on</span> <%= item.getLocation() %>
    </div>
    </td>
    <td class="px-6 py-5">
    <div class="flex flex-col gap-1">
    <% if ("open".equals(item.getStatus())) { %>
    <span class="flex items-center gap-1.5 text-[10px] font-bold uppercase tracking-wider text-primary">
    <span class="w-1.5 h-1.5 rounded-full bg-primary animate-pulse"></span> Open
    </span>
    <% } else { %>
    <span class="flex items-center gap-1.5 text-[10px] font-bold uppercase tracking-wider text-tertiary">
    <span class="w-1.5 h-1.5 rounded-full bg-tertiary"></span> Resolved
    </span>
    <% } %>
    <span class="text-[10px] text-on-surface-variant"><%= item.getDateReported() %></span>
    </div>
    </td>
    <td class="px-6 py-5 text-right">
    <div class="flex justify-end gap-2">
    <a href="<%= ctx %>/itemDetail?id=<%= item.getItemId() %>" target="_blank" class="p-2 text-primary hover:bg-primary-container/20 rounded-lg transition-all" title="View Detail">
    <span class="material-symbols-outlined text-lg" data-icon="visibility">visibility</span>
    </a>
    <a href="<%= ctx %>/deleteItem?id=<%= item.getItemId() %>" onclick="return confirm('Are you sure you want to delete this artifact?')" class="p-2 text-error hover:bg-error-container/20 rounded-lg transition-all" title="Delete Artifact">
    <span class="material-symbols-outlined text-lg" data-icon="delete">delete</span>
    </a>
    </div>
    </td>
    </tr>
    <% } %>
    </tbody>
    </table>
    </div>
    </section>
    <% } %>
</div>

</div>
</main>

<!-- ===== REPORT DOWNLOAD MODAL ===== -->
<div id="reportModal" class="hidden fixed inset-0 z-50 flex items-center justify-center bg-black/40 backdrop-blur-sm">
    <div class="bg-white dark:bg-slate-900 rounded-2xl shadow-2xl w-full max-w-md mx-4 p-8 relative">
        <!-- Close button -->
        <button onclick="document.getElementById('reportModal').classList.add('hidden')"
            class="absolute top-4 right-4 text-slate-400 hover:text-slate-700 transition-colors">
            <span class="material-symbols-outlined text-2xl">close</span>
        </button>

        <!-- Header -->
        <div class="flex items-center gap-3 mb-6">
            <div class="w-11 h-11 rounded-xl bg-primary/10 flex items-center justify-center">
                <span class="material-symbols-outlined text-primary text-xl">summarize</span>
            </div>
            <div>
                <h3 class="text-lg font-black text-on-surface tracking-tight">Download Report</h3>
                <p class="text-xs text-on-surface-variant">Select a date range to generate a CSV report</p>
            </div>
        </div>

        <!-- Form -->
        <div id="reportError" class="hidden mb-4 bg-error-container text-on-error-container text-xs font-semibold px-4 py-3 rounded-lg"></div>

        <div class="flex flex-col gap-4">
            <div>
                <label class="block text-[10px] font-bold text-on-surface-variant uppercase tracking-widest mb-1.5">From Date</label>
                <input type="date" id="reportFrom"
                    class="w-full border border-outline-variant rounded-xl px-4 py-2.5 text-sm text-on-surface bg-surface-container-low focus:outline-none focus:ring-2 focus:ring-primary/30"/>
            </div>
            <div>
                <label class="block text-[10px] font-bold text-on-surface-variant uppercase tracking-widest mb-1.5">To Date</label>
                <input type="date" id="reportTo"
                    class="w-full border border-outline-variant rounded-xl px-4 py-2.5 text-sm text-on-surface bg-surface-container-low focus:outline-none focus:ring-2 focus:ring-primary/30"/>
            </div>
        </div>

        <!-- Quick presets -->
        <div class="flex gap-2 mt-4 flex-wrap">
            <button onclick="setReportPreset(7)"  class="text-[10px] font-bold uppercase tracking-wider px-3 py-1.5 rounded-lg bg-surface-container text-on-surface-variant hover:bg-surface-container-high transition-colors">Last 7 days</button>
            <button onclick="setReportPreset(30)" class="text-[10px] font-bold uppercase tracking-wider px-3 py-1.5 rounded-lg bg-surface-container text-on-surface-variant hover:bg-surface-container-high transition-colors">Last 30 days</button>
            <button onclick="setReportPreset(90)" class="text-[10px] font-bold uppercase tracking-wider px-3 py-1.5 rounded-lg bg-surface-container text-on-surface-variant hover:bg-surface-container-high transition-colors">Last 90 days</button>
        </div>

        <!-- Actions -->
        <div class="flex gap-3 mt-7">
            <button onclick="document.getElementById('reportModal').classList.add('hidden')"
                class="flex-1 px-4 py-2.5 rounded-xl border border-outline-variant text-sm font-semibold text-on-surface-variant hover:bg-surface-container transition-colors">
                Cancel
            </button>
            <button onclick="downloadReport()"
                class="flex-1 flex items-center justify-center gap-2 bg-primary text-white px-4 py-2.5 rounded-xl text-sm font-semibold shadow-md shadow-primary/20 hover:scale-[1.02] active:scale-95 transition-all">
                <span class="material-symbols-outlined text-base">download</span>
                Download CSV
            </button>
        </div>
    </div>
</div>

<script>
    function switchTabAdmin(tab) {
        // Hide all tabs
        document.querySelectorAll('.admin-tab').forEach(t => {
            t.classList.remove('active');
        });
        
        // Reset sidebar active states
        document.querySelectorAll('.nav-link-item').forEach(l => {
            l.classList.remove('bg-white', 'dark:bg-slate-800', 'text-blue-700', 'dark:text-blue-300', 'shadow-sm');
            l.classList.add('text-slate-500', 'dark:text-slate-400');
        });
        
        // Show target tab
        document.getElementById('tab-' + tab).classList.add('active');
        
        // Highlight active sidebar item
        const navEl = document.getElementById('nav-' + tab);
        if (navEl) {
            navEl.classList.remove('text-slate-500', 'dark:text-slate-400', 'hover:text-slate-900', 'hover:bg-slate-100');
            navEl.classList.add('bg-white', 'dark:bg-slate-800', 'text-blue-700', 'dark:text-blue-300', 'shadow-sm');
        }
    }

    // Auto-open claims tab if there are pending claims and URL param says so
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('tab') === 'claims') switchTabAdmin('claims');

    // Close modal on backdrop click
    document.getElementById('reportModal').addEventListener('click', function(e) {
        if (e.target === this) this.classList.add('hidden');
    });

    function setReportPreset(days) {
        const today = new Date();
        const from  = new Date();
        from.setDate(today.getDate() - (days - 1));
        document.getElementById('reportFrom').value = from.toISOString().split('T')[0];
        document.getElementById('reportTo').value   = today.toISOString().split('T')[0];
        document.getElementById('reportError').classList.add('hidden');
    }

    function downloadReport() {
        const from = document.getElementById('reportFrom').value;
        const to   = document.getElementById('reportTo').value;
        const errEl = document.getElementById('reportError');

        if (!from || !to) {
            errEl.textContent = 'Please select both a start and end date.';
            errEl.classList.remove('hidden');
            return;
        }
        if (from > to) {
            errEl.textContent = '"From" date cannot be after "To" date.';
            errEl.classList.remove('hidden');
            return;
        }

        errEl.classList.add('hidden');
        const ctx = '<%= request.getContextPath() %>';
        window.location.href = ctx + '/adminReport?from=' + from + '&to=' + to;
        document.getElementById('reportModal').classList.add('hidden');
    }
</script>
</body></html>
