<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.lostfound.model.Item, com.lostfound.model.Claim, com.lostfound.model.User" %>
<%
    String ctx = request.getContextPath();
    Item item = (Item) request.getAttribute("item");
    List<Claim> claims = (List<Claim>) request.getAttribute("claims");
    User loggedUser = (User) session.getAttribute("loggedUser");
    Boolean alreadyClaimed = (Boolean) request.getAttribute("alreadyClaimed");
    Boolean isOwner = (Boolean) request.getAttribute("isOwner");
    String success = (String) request.getAttribute("success");
    if (alreadyClaimed == null) alreadyClaimed = false;
    if (isOwner == null) isOwner = false;

    if (item == null) {
        response.sendRedirect(ctx + "/items");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title><%= item.getTitle() %> | The Academic Curator</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
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
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; vertical-align: middle; }
        body { font-family: 'Inter', sans-serif; }
</style>
</head>
<body class="bg-surface text-on-surface min-h-screen flex flex-col">

<!-- TopNavBar -->
<nav class="bg-slate-50/80 backdrop-blur-xl dark:bg-slate-950/80 shadow-sm dark:shadow-none docked full-width top-0 sticky z-50">
<div class="flex justify-between items-center w-full px-8 py-4 max-w-7xl mx-auto">
<a href="<%= ctx %>/" class="text-2xl font-bold tracking-tighter text-blue-700 dark:text-blue-500">The Academic Curator</a>
<div class="hidden md:flex gap-8 items-center">
<a class="text-blue-600 dark:text-blue-400 border-b-2 border-blue-600 pb-1 font-semibold uppercase tracking-widest text-xs transition-all duration-200" href="<%= ctx %>/items">Browse</a>
<% if (loggedUser != null) { %>
<a class="text-slate-500 dark:text-slate-400 font-medium hover:text-blue-500 dark:hover:text-blue-300 transition-colors uppercase tracking-widest text-xs" href="<%= ctx %>/reportItem">Report</a>
<a class="text-slate-500 dark:text-slate-400 font-medium hover:text-blue-500 dark:hover:text-blue-300 transition-colors uppercase tracking-widest text-xs" href="<%= ctx %>/myItems">My Items</a>
<% } else { %>
<a class="text-slate-500 dark:text-slate-400 font-medium hover:text-blue-500 dark:hover:text-blue-300 transition-colors uppercase tracking-widest text-xs" href="<%= ctx %>/login">Login</a>
<a class="text-slate-500 dark:text-slate-400 font-medium hover:text-blue-500 dark:hover:text-blue-300 transition-colors uppercase tracking-widest text-xs" href="<%= ctx %>/register">Register</a>
<% } %>
</div>
<div class="flex items-center gap-4">
<% if (loggedUser != null) { %>
<a href="<%= ctx %>/logout" title="Logout" class="material-symbols-outlined text-on-surface-variant hover:text-error transition-colors p-2" data-icon="logout">logout</a>
<% } else { %>
<a href="<%= ctx %>/login" title="Login" class="material-symbols-outlined text-on-surface-variant hover:text-primary transition-colors p-2" data-icon="account_circle">account_circle</a>
<% } %>
</div>
</div>
</nav>

<main class="flex-grow max-w-7xl mx-auto px-6 py-12 w-full">

    <% if (success != null) { %>
        <div class="mb-8 p-4 bg-tertiary-container/30 text-on-tertiary-container font-medium rounded-xl flex items-center gap-2 border border-tertiary-container">
            <span class="material-symbols-outlined font-bold">check_circle</span>
            <%= success %>
        </div>
    <% } %>

    <div class="mb-6">
        <a href="<%= ctx %>/items" class="inline-flex items-center gap-2 text-sm font-bold text-outline hover:text-primary transition-colors uppercase tracking-widest">
            <span class="material-symbols-outlined text-[16px]">arrow_back</span> Back to Items
        </a>
    </div>

    <!-- Main Grid -->
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-10">
        
        <!-- Left Column: Visual & Description -->
        <div class="lg:col-span-2 space-y-8">
            <div class="w-full aspect-[4/3] max-h-[500px] bg-surface-container-low rounded-2xl overflow-hidden flex items-center justify-center relative shadow-[0px_12px_32px_rgba(25,27,35,0.04)]">
                <% if (item.getImagePath() != null && !item.getImagePath().isEmpty()) { %>
                    <img src="<%= ctx %>/images/uploads/<%= item.getImagePath() %>" alt="<%= item.getTitle() %>" class="w-full h-full object-cover">
                <% } else { %>
                    <span class="text-8xl opacity-80">
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
                <div class="absolute top-6 left-6 flex gap-3">
                    <span class="px-4 py-2 <%= "lost".equals(item.getType()) ? "bg-error-container text-on-error-container" : "bg-tertiary-container text-on-tertiary-container" %> text-[10px] font-black rounded-full uppercase tracking-widest shadow-lg backdrop-blur-md">
                        <%= "lost".equals(item.getType()) ? "Lost Artifact" : "Found Artifact" %>
                    </span>
                    <span class="px-4 py-2 <%= "open".equals(item.getStatus()) ? "bg-primary-container text-on-primary-container" : "bg-surface-variant text-on-surface-variant" %> text-[10px] font-black rounded-full uppercase tracking-widest shadow-lg backdrop-blur-md">
                        <%= "open".equals(item.getStatus()) ? "Folder Open" : "Resolved" %>
                    </span>
                </div>
            </div>

            <% if (item.getDescription() != null && !item.getDescription().isEmpty()) { %>
            <div class="bg-surface-container-lowest p-8 rounded-2xl border border-outline-variant/20 shadow-sm">
                <h3 class="text-sm font-bold uppercase tracking-widest text-on-surface mb-4">Detailed Description</h3>
                <p class="text-on-surface-variant leading-relaxed"><%= item.getDescription() %></p>
            </div>
            <% } %>
        </div>

        <!-- Right Column: Metadata & Actions -->
        <div class="space-y-6">
            <div class="bg-surface-container-lowest p-8 rounded-2xl border border-outline-variant/20 shadow-sm">
                <h1 class="text-3xl font-extrabold tracking-tight text-on-surface mb-2"><%= item.getTitle() %></h1>
                <p class="text-sm text-on-surface-variant mb-8 flex items-center gap-2">
                    <span class="material-symbols-outlined text-[16px]">person</span> Reported by <strong class="text-on-surface"><%= item.getReporterName() %></strong>
                </p>

                <div class="space-y-5">
                    <div class="flex items-center gap-4">
                        <div class="w-10 h-10 rounded-full bg-secondary-container/30 text-on-secondary-container flex items-center justify-center shrink-0">
                            <span class="material-symbols-outlined text-[20px]">category</span>
                        </div>
                        <div>
                            <p class="text-[10px] font-bold uppercase tracking-widest text-outline">Category</p>
                            <p class="font-semibold text-on-surface"><%= item.getCategory() %></p>
                        </div>
                    </div>

                    <div class="flex items-center gap-4">
                        <div class="w-10 h-10 rounded-full bg-secondary-container/30 text-on-secondary-container flex items-center justify-center shrink-0">
                            <span class="material-symbols-outlined text-[20px]">location_on</span>
                        </div>
                        <div>
                            <p class="text-[10px] font-bold uppercase tracking-widest text-outline">Location</p>
                            <p class="font-semibold text-on-surface"><%= item.getLocation() %></p>
                        </div>
                    </div>

                    <div class="flex items-center gap-4">
                        <div class="w-10 h-10 rounded-full bg-secondary-container/30 text-on-secondary-container flex items-center justify-center shrink-0">
                            <span class="material-symbols-outlined text-[20px]">calendar_today</span>
                        </div>
                        <div>
                            <p class="text-[10px] font-bold uppercase tracking-widest text-outline">Date Reported</p>
                            <p class="font-semibold text-on-surface"><%= item.getDateReported() %></p>
                        </div>
                    </div>

                    <div class="pt-4 border-t border-surface-container-high mt-4">
                        <div class="flex items-center gap-4 mt-2">
                            <div class="w-10 h-10 rounded-full bg-primary-container/30 text-on-primary-container flex items-center justify-center shrink-0">
                                <span class="material-symbols-outlined text-[20px]">mail</span>
                            </div>
                            <div>
                                <p class="text-[10px] font-bold uppercase tracking-widest text-outline">Contact Email</p>
                                <p class="font-semibold text-on-surface select-all"><%= item.getReporterEmail() %></p>
                            </div>
                        </div>
                        <% if (item.getReporterPhone() != null && !item.getReporterPhone().isEmpty()) { %>
                        <div class="flex items-center gap-4 mt-5">
                            <div class="w-10 h-10 rounded-full bg-primary-container/30 text-on-primary-container flex items-center justify-center shrink-0">
                                <span class="material-symbols-outlined text-[20px]">phone</span>
                            </div>
                            <div>
                                <p class="text-[10px] font-bold uppercase tracking-widest text-outline">Contact Phone</p>
                                <p class="font-semibold text-on-surface select-all"><%= item.getReporterPhone() %></p>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>

            <!-- Contextual Action Area -->
            <div class="mt-6">
                <% if (loggedUser != null && !isOwner && "open".equals(item.getStatus())) { %>
                    <% if ("found".equals(item.getType())) { %>
                        <!-- FOUND item, allow claiming -->
                        <% if (alreadyClaimed) { %>
                            <div class="bg-primary-container/20 text-on-primary-container p-6 rounded-2xl border border-primary-container flex flex-col items-center justify-center text-center">
                                <span class="material-symbols-outlined text-3xl mb-2 text-primary">verified_user</span>
                                <p class="font-bold">Claim Under Review</p>
                                <p class="text-xs text-on-surface-variant mt-2">Your claim for this artifact has been submitted and is awaiting administrator approval.</p>
                            </div>
                        <% } else { %>
                            <button onclick="document.getElementById('claimModal').classList.remove('hidden')" class="w-full py-4 bg-gradient-to-r from-tertiary to-tertiary-container text-white font-bold rounded-xl shadow-lg shadow-tertiary/25 hover:brightness-105 active:scale-[0.98] transition-all flex items-center justify-center gap-2">
                                <span class="material-symbols-outlined" data-icon="front_hand">front_hand</span>
                                Claim This Artifact
                            </button>
                        <% } %>
                    <% } else if ("lost".equals(item.getType())) { %>
                        <!-- LOST item, encourage contact -->
                        <div class="bg-tertiary-container/30 text-on-surface p-6 rounded-2xl border border-tertiary-container/50 text-center">
                            <span class="material-symbols-outlined text-4xl mb-2 text-tertiary">contact_support</span>
                            <h3 class="font-bold mb-1">Did you find this item?</h3>
                            <p class="text-xs text-on-surface-variant mb-4">Please contact <strong><%= item.getReporterName() %></strong> directly using the details above to organize a return.</p>
                            <a href="mailto:<%= item.getReporterEmail() %>" class="w-full block py-3 bg-tertiary text-white font-bold rounded-xl shadow-md cursor-pointer hover:bg-tertiary/90 transition-colors">
                                Email Reporter
                            </a>
                        </div>
                    <% } %>
                <% } else if (loggedUser == null) { %>
                    <a href="<%= ctx %>/login" class="w-full flex py-4 bg-primary text-white font-bold rounded-xl shadow-lg shadow-primary/25 hover:bg-primary/90 transition-all items-center justify-center gap-2">
                        <span class="material-symbols-outlined" data-icon="login">login</span>
                        Login to Interact
                    </a>
                <% } else if (isOwner) { %>
                    <div class="bg-surface-variant/50 text-on-surface p-6 rounded-2xl border border-surface-variant text-center">
                        <span class="material-symbols-outlined text-3xl mb-2 text-outline">admin_panel_settings</span>
                        <p class="font-bold text-sm tracking-widest uppercase">Your Record</p>
                        <p class="text-xs text-on-surface-variant mt-2">You created this artifact record.</p>
                    </div>
                <% } else if ("resolved".equals(item.getStatus())) { %>
                    <div class="bg-surface-container-high text-on-surface p-6 rounded-2xl text-center">
                        <span class="material-symbols-outlined text-4xl mb-2 text-primary">task_alt</span>
                        <h3 class="font-bold mb-1">Resolved Artifact</h3>
                        <p class="text-xs text-on-surface-variant">This item has been successfully reclaimed or removed.</p>
                    </div>
                <% } %>
            </div>

            <!-- Claims Received (Owner only) -->
            <% if (isOwner && claims != null && !claims.isEmpty()) { %>
                <div class="bg-surface-container-lowest rounded-2xl border border-outline-variant/20 shadow-sm overflow-hidden mt-8">
                    <div class="p-6 border-b border-surface-container-low flex items-center justify-between">
                        <h3 class="font-bold text-sm uppercase tracking-widest">Claims Received</h3>
                        <span class="bg-primary-container text-on-primary-container px-3 py-1 rounded-full text-xs font-bold"><%= claims.size() %></span>
                    </div>
                    <div class="divide-y divide-surface-container-low">
                        <% for (Claim c : claims) { %>
                            <div class="p-6 <%= "pending".equals(c.getStatus()) ? "bg-primary-container/5" : "" %>">
                                <div class="flex justify-between items-start mb-3">
                                    <div>
                                        <p class="font-bold text-on-surface"><%= c.getClaimantName() %></p>
                                        <p class="text-xs text-on-surface-variant mt-1"><%= c.getClaimantEmail() %></p>
                                    </div>
                                    <span class="px-2 py-1 bg-surface-container-high rounded text-[10px] font-bold uppercase tracking-wider text-outline"><%= c.getStatus() %></span>
                                </div>
                                <div class="bg-surface p-3 rounded-lg border border-surface-container-highest mt-3">
                                    <p class="text-xs text-on-surface-variant break-words"><%= c.getProofDescription() %></p>
                                </div>
                                <div class="mt-3 text-[10px] text-outline font-medium text-right">
                                    Submitted <%= c.getClaimedAt() != null ? c.getClaimedAt().toString().substring(0,10) : "" %>
                                </div>
                            </div>
                        <% } %>
                    </div>
                </div>
            <% } %>

        </div>
    </div>
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

<!-- Claim Modal -->
<div id="claimModal" class="hidden fixed inset-0 z-[100] flex items-center justify-center p-4">
    <!-- Backdrop -->
    <div class="absolute inset-0 bg-slate-950/60 backdrop-blur-sm cursor-pointer" onclick="document.getElementById('claimModal').classList.add('hidden')"></div>
    
    <!-- Modal Content -->
    <div class="bg-surface-container-lowest w-full max-w-md rounded-2xl shadow-2xl relative z-10 overflow-hidden flex flex-col max-h-[90vh]">
        <div class="p-6 border-b border-surface-container-high flex items-center justify-between bg-surface-container-low/50">
            <h3 class="font-extrabold text-xl tracking-tight text-on-surface">Submit a Claim</h3>
            <button onclick="document.getElementById('claimModal').classList.add('hidden')" class="w-8 h-8 flex items-center justify-center rounded-full hover:bg-surface-variant/50 transition-colors text-outline">
                <span class="material-symbols-outlined text-[20px]">close</span>
            </button>
        </div>
        
        <div class="p-6 overflow-y-auto">
            <p class="text-sm text-on-surface-variant mb-6 leading-relaxed">
                Since this item was <strong>Found</strong>, please describe it in detail to prove you are the rightful owner. Mention serial numbers, unique marks, contents, or passwords.
            </p>
            
            <form action="<%= ctx %>/claim" method="post" id="claimForm">
                <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                <div class="flex flex-col space-y-2 border-b-2 border-outline-variant/30 focus-within:border-tertiary transition-colors">
                    <label class="font-bold uppercase tracking-widest text-[10px] text-tertiary">Proof of Ownership <span class="text-error">*</span></label>
                    <textarea name="proofDescription" class="w-full bg-transparent border-none p-0 focus:ring-0 text-on-surface placeholder:text-outline/40 font-medium py-2 resize-none" rows="5" placeholder="e.g. The bag has a red keychain, contains engineering drawing instruments..." required></textarea>
                </div>
            </form>
        </div>
        
        <div class="p-6 border-t border-surface-container-high bg-surface-container-low/50 flex items-center justify-end gap-3">
            <button type="button" onclick="document.getElementById('claimModal').classList.add('hidden')" class="px-5 py-2.5 text-sm font-bold text-on-surface-variant hover:bg-surface-variant/50 rounded-xl transition-colors">
                Cancel
            </button>
            <button type="submit" form="claimForm" class="px-6 py-2.5 text-sm font-bold bg-tertiary text-white rounded-xl shadow-lg hover:bg-tertiary/90 active:scale-95 transition-all">
                Submit Claim
            </button>
        </div>
    </div>
</div>

<script src="<%= ctx %>/js/main.js"></script>
</body>
</html>
