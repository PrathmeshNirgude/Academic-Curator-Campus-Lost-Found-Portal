<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.lostfound.model.User" %>
<%
    User loggedUser = (User) session.getAttribute("loggedUser");
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>The Academic Curator | Campus Lost &amp; Found</title>
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
        body { font-family: 'Inter', sans-serif; background-color: #faf8ff; }
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
        .glass-nav { backdrop-filter: blur(20px); -webkit-backdrop-filter: blur(20px); }
        .hero-gradient { background: linear-gradient(135deg, #004ac6 0%, #2563eb 100%); }
    </style>
</head>
<body class="text-on-surface">
<!-- TopNavBar -->
<header class="bg-slate-50/80 backdrop-blur-xl dark:bg-slate-950/80 docked full-width top-0 sticky z-50 shadow-sm dark:shadow-none">
<div class="flex justify-between items-center w-full px-8 py-4 max-w-7xl mx-auto">
<div class="flex items-center gap-8">
<a href="<%= ctx %>/" class="text-2xl font-bold tracking-tighter text-blue-700 dark:text-blue-500">The Academic Curator</a>
<nav class="hidden md:flex items-center gap-6">
<a class="text-blue-600 dark:text-blue-400 border-b-2 border-blue-600 pb-1 font-semibold hover:text-blue-500 dark:hover:text-blue-300 transition-colors active:scale-[0.98] transition-all duration-200" href="<%= ctx %>/items">Browse</a>
<% if (loggedUser != null) { %>
<a class="text-slate-500 dark:text-slate-400 font-medium hover:text-blue-500 dark:hover:text-blue-300 transition-colors active:scale-[0.98] transition-all duration-200" href="<%= ctx %>/reportItem">Report</a>
<a class="text-slate-500 dark:text-slate-400 font-medium hover:text-blue-500 dark:hover:text-blue-300 transition-colors active:scale-[0.98] transition-all duration-200" href="<%= ctx %>/myItems">My Items</a>
<% } else { %>
<a class="text-slate-500 dark:text-slate-400 font-medium hover:text-blue-500 dark:hover:text-blue-300 transition-colors active:scale-[0.98] transition-all duration-200" href="<%= ctx %>/login">Login</a>
<a class="text-slate-500 dark:text-slate-400 font-medium hover:text-blue-500 dark:hover:text-blue-300 transition-colors active:scale-[0.98] transition-all duration-200" href="<%= ctx %>/register">Register</a>
<% } %>
</nav>
</div>
<div class="flex items-center gap-4">
<form action="<%= ctx %>/items" method="get" class="hidden md:flex items-center bg-surface-container px-4 py-2 rounded-xl text-on-surface-variant">
<span class="material-symbols-outlined text-sm mr-2" data-icon="search">search</span>
<input name="keyword" class="bg-transparent border-none focus:ring-0 text-sm w-48" placeholder="Search for items..." type="text"/>
<button type="submit" class="hidden">Search</button>
</form>
<% if (loggedUser != null) { %>
<a href="<%= ctx %>/logout" title="Logout" class="material-symbols-outlined text-slate-500 hover:text-error transition-colors" data-icon="logout">logout</a>
<% } else { %>
<a href="<%= ctx %>/login" title="Login" class="material-symbols-outlined text-slate-500 hover:text-primary transition-colors" data-icon="account_circle">account_circle</a>
<% } %>
</div>
</div>
</header>
<main>
<!-- Hero Section -->
<section class="relative overflow-hidden pt-12 pb-24 md:pt-24 md:pb-32 px-8">
<div class="max-w-7xl mx-auto flex flex-col md:flex-row items-center gap-16">
<div class="w-full md:w-1/2 space-y-8 z-10">
<div class="inline-flex items-center gap-2 px-3 py-1 bg-primary-fixed text-on-primary-fixed rounded-full">
<span class="material-symbols-outlined text-sm" data-icon="auto_awesome">auto_awesome</span>
<span class="text-[10px] font-bold uppercase tracking-widest">Campus Lost &amp; Found Portal</span>
</div>
<h1 class="text-5xl md:text-7xl font-bold tracking-tight text-on-surface leading-[1.1]">
                        Helping students <span class="text-primary italic">reunite</span> with their belongings.
                    </h1>
<p class="text-lg text-on-surface-variant leading-relaxed max-w-lg">
                        The Digital Curator transforms the stressful experience of losing an item into a serene, organized, and authoritative editorial journey.
                    </p>
<div class="flex flex-wrap gap-4 pt-4">
<a href="<%= ctx %>/items" class="hero-gradient px-8 py-4 rounded-xl text-white font-semibold flex items-center gap-2 shadow-xl hover:opacity-90 transition-all">
<span class="material-symbols-outlined" data-icon="search_check">search_check</span>
                            Browse Found Items
                        </a>
<% if (loggedUser == null) { %>
<a href="<%= ctx %>/register" class="bg-error px-8 py-4 rounded-xl text-white font-semibold flex items-center gap-2 shadow-lg hover:opacity-90 transition-all">
<span class="material-symbols-outlined" data-icon="rocket_launch">rocket_launch</span>
                            Get Started Free
                        </a>
<% } else { %>
<a href="<%= ctx %>/reportItem" class="bg-error px-8 py-4 rounded-xl text-white font-semibold flex items-center gap-2 shadow-lg hover:opacity-90 transition-all">
<span class="material-symbols-outlined" data-icon="report">report</span>
                            Report Lost Item
                        </a>
<% } %>
</div>
</div>
<div class="w-full md:w-1/2 relative">
<div class="aspect-[4/5] rounded-[2.5rem] overflow-hidden shadow-2xl relative">
<img alt="Lost items being curated" class="w-full h-full object-cover" data-alt="Minimalist top-down view of premium student accessories like leather notebooks, mechanical pencils, and metal spectacles on a clean marble surface" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDOgOTxLMz4MOajPteUUf8Gn1IuECVjqs_vBw9urtuNH7t15kUuDACKXEmD-VfyB1C4k5ygDOgGJm3hyz8hdg2w-QoHF1HEQ02NN9_lYVGUEKtNrIdkOhNZad4PwRcaYEUAyK6WZPnxwwjqU3C1TXzyx61BzaSB2ZIzVrZMnUSiXt3N4Apf0SohWY0NNoof9Gz9wVPcs_VlvqIEdj5bnfwGVJlfcmjQ8ITnKH9PtYw07MW5sgZzsxo8NMJgRc7Beq17NIhHgBcydaY"/>
<div class="absolute inset-0 bg-gradient-to-t from-primary/20 to-transparent"></div>
<!-- Floating Artifact Card -->
<div class="absolute bottom-8 right-8 bg-surface-container-lowest/90 backdrop-blur-md p-6 rounded-2xl shadow-2xl max-w-[240px] border border-white/20">
<div class="flex justify-between items-start mb-4">
<span class="bg-tertiary-container/90 text-[10px] font-bold text-on-tertiary-container px-2 py-1 rounded-md uppercase tracking-wider">FOUND</span>
<span class="text-on-surface-variant text-[10px] font-medium">2 HOURS AGO</span>
</div>
<h4 class="font-bold text-on-surface mb-1">Graphite iPad Pro</h4>
<p class="text-xs text-on-surface-variant mb-4">Central Library • Desk 42</p>
<div class="h-1 w-full bg-surface-container-high rounded-full overflow-hidden">
<div class="h-full bg-tertiary w-3/4"></div>
</div>
</div>
</div>
<!-- Decorative Background Element -->
<div class="absolute -top-12 -right-12 w-64 h-64 bg-primary/5 rounded-full blur-3xl -z-10"></div>
</div>
</div>
</section>
<!-- Process Section: Tonal Nesting -->
<section class="bg-surface-container-low py-24 px-8">
<div class="max-w-7xl mx-auto">
<div class="flex flex-col md:flex-row md:items-end justify-between mb-16 gap-4">
<div class="max-w-xl">
<span class="text-tertiary font-bold uppercase tracking-widest text-[10px]">The Workflow</span>
<h2 class="text-4xl font-bold tracking-tight mt-2">How we reunite belongings</h2>
</div>
<p class="text-on-surface-variant max-w-sm">
                        A seamless, automated system designed to bridge the gap between lost possessions and their owners.
                    </p>
</div>
<div class="grid grid-cols-1 md:grid-cols-3 gap-8">
<!-- Step 1: Report -->
<div class="bg-surface-container-lowest p-10 rounded-[2rem] shadow-sm flex flex-col gap-6">
<div class="w-14 h-14 bg-error-container text-on-error-container rounded-2xl flex items-center justify-center">
<span class="material-symbols-outlined text-3xl" data-icon="assignment_late">assignment_late</span>
</div>
<div>
<span class="text-[10px] font-bold text-outline uppercase tracking-widest">Phase 01</span>
<h3 class="text-2xl font-bold mt-1 mb-3">Report</h3>
<p class="text-on-surface-variant text-sm leading-relaxed">
                                Log your lost item with precise details, location, and metadata. Our system archives it immediately in the campus ledger.
                            </p>
</div>
</div>
<!-- Step 2: Verify -->
<div class="bg-surface-container-lowest p-10 rounded-[2rem] shadow-sm flex flex-col gap-6">
<div class="w-14 h-14 bg-primary-fixed text-on-primary-fixed rounded-2xl flex items-center justify-center">
<span class="material-symbols-outlined text-3xl" data-icon="fact_check">fact_check</span>
</div>
<div>
<span class="text-[10px] font-bold text-outline uppercase tracking-widest">Phase 02</span>
<h3 class="text-2xl font-bold mt-1 mb-3">Verify</h3>
<p class="text-on-surface-variant text-sm leading-relaxed">
                                Our curators compare reports against found items. We use smart matching to verify ownership through security questions.
                            </p>
</div>
</div>
<!-- Step 3: Recover -->
<div class="bg-surface-container-lowest p-10 rounded-[2rem] shadow-sm flex flex-col gap-6">
<div class="w-14 h-14 bg-tertiary-fixed text-on-tertiary-fixed-variant rounded-2xl flex items-center justify-center">
<span class="material-symbols-outlined text-3xl" data-icon="handshake">handshake</span>
</div>
<div>
<span class="text-[10px] font-bold text-outline uppercase tracking-widest">Phase 03</span>
<h3 class="text-2xl font-bold mt-1 mb-3">Recover</h3>
<p class="text-on-surface-variant text-sm leading-relaxed">
                                Receive a secure collection code and pick up your artifact from the designated campus concierge desk.
                            </p>
</div>
</div>
</div>
</div>
</section>
<!-- Asymmetric Artifact Grid -->
<section class="py-24 px-8 overflow-hidden">
<div class="max-w-7xl mx-auto">
<div class="grid grid-cols-12 gap-8">
<!-- Side Card 2 -->
<div class="col-span-12 md:col-span-6 lg:col-span-4">
<div class="bg-surface-container-low p-8 rounded-[2rem] flex flex-col h-full border border-outline-variant/20">
<div class="mb-auto">
<h4 class="text-xl font-bold mb-4">Missing something else?</h4>
<p class="text-on-surface-variant text-sm leading-relaxed mb-8">
                                    We have a catalog of over 400 items recovered this semester alone. Our concierge team is here to help you navigate the search.
                                </p>
</div>
<a href="<%= ctx %>/items" class="bg-surface-container-highest w-full py-4 rounded-xl text-on-surface font-bold hover:bg-surface-variant transition-colors flex items-center justify-center">
                                View Full Directory
                            </a>
</div>
</div>
<!-- Map/Zone Component -->
<div class="col-span-12 lg:col-span-8 relative">
<div class="bg-surface-container-high rounded-[2.5rem] p-10 h-full flex flex-col md:flex-row gap-10 items-center overflow-hidden">
<div class="w-full md:w-1/2">
<h3 class="text-2xl font-bold mb-4">Pinpoint Loss Location</h3>
<p class="text-on-surface-variant text-sm mb-6">
                                    We organize reported items securely based on the precise location provided by the finder or owner, making it easier for campus authorities to facilitate a quick reunion.
                                </p>
<div class="flex flex-wrap gap-2">
<span class="bg-secondary-container text-on-secondary-container px-3 py-1 rounded-full text-[10px] font-bold uppercase">North Quad</span>
<span class="bg-secondary-container text-on-secondary-container px-3 py-1 rounded-full text-[10px] font-bold uppercase">Sports Hall</span>
<span class="bg-secondary-container text-on-secondary-container px-3 py-1 rounded-full text-[10px] font-bold uppercase">Main Library</span>
</div>
</div>
<div class="w-full md:w-1/2 aspect-video md:aspect-square bg-slate-200 rounded-3xl relative overflow-hidden shadow-inner">
<img alt="Campus map" class="w-full h-full object-cover grayscale opacity-50" data-alt="Clean architectural 3D render of a college campus map with green spaces and modern white buildings" data-location="University Campus" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAMmzWKzv9Sone2KgB6cPFiXvJNo-MO8MVCDmq2dACJVBpoWEUmD_ddmTLUuWOXydkOuuqriyR99qgxellrXc8G3H6qou9K5424Y-vAv5-YnUhLY7lumALjpWjnQP9v3ptY7hYtvvIkXAORsGnVPrLUnu51d-9gjSCAyp5OLk1jSwz4yBlo2jd4sE-V3ggVgWkD6oIiyErECZFVfwp-X_wE9VAYr_j4at0n_mSoFN9W4SVC06fgTCS_YMp2knj68X6xZ8RerDUnslM"/>
<div class="absolute inset-0 flex items-center justify-center">
<div class="w-12 h-12 bg-primary/20 rounded-full flex items-center justify-center animate-pulse">
<div class="w-4 h-4 bg-primary rounded-full"></div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</section>
<!-- CTA Section -->
<section class="py-24 px-8">
<div class="max-w-4xl mx-auto hero-gradient rounded-[3rem] p-12 md:p-20 text-center text-white relative overflow-hidden">
<div class="absolute -top-24 -left-24 w-64 h-64 bg-white/10 rounded-full blur-3xl"></div>
<div class="relative z-10">
<h2 class="text-4xl md:text-5xl font-bold mb-8">Ready to start the search?</h2>
<p class="text-white/80 text-lg mb-12 max-w-xl mx-auto">
                        Whether you've found a lost treasure or misplaced your own, we're here to facilitate the reunion.
                    </p>
<div class="flex flex-col sm:flex-row justify-center gap-4">
<a href="<%= ctx %>/reportItem" class="bg-white text-primary px-10 py-4 rounded-xl font-bold shadow-lg hover:bg-slate-50 transition-colors flex items-center justify-center">
                            Submit a Claim
                        </a>
<a href="<%= ctx %>/items" class="bg-primary-container text-white border border-white/20 px-10 py-4 rounded-xl font-bold hover:bg-white/10 transition-colors flex items-center justify-center">
                            Support Center
                        </a>
</div>
</div>
</div>
</section>
</main>
<!-- Footer -->
<footer class="bg-white dark:bg-slate-900 w-full py-12 mt-auto">
<div class="flex flex-col md:flex-row justify-between items-start px-12 max-w-7xl mx-auto gap-8">
<div class="max-w-xs">
<span class="text-xl font-bold text-slate-900 dark:text-slate-100">The Academic Curator</span>
<p class="text-sm Inter text-slate-500 dark:text-slate-400 mt-4 leading-relaxed">
                    © 2026 The Academic Curator. Elevating campus lost &amp; found to a digital concierge experience.
                </p>
</div>
<div class="grid grid-cols-2 gap-12">
<div class="flex flex-col gap-3">
<span class="font-bold uppercase tracking-widest text-[10px] text-slate-900 dark:text-slate-100">Navigation</span>
<a class="text-slate-500 dark:text-slate-400 hover:text-blue-700 dark:hover:text-blue-300 transition-opacity text-sm" href="#">Privacy Policy</a>
<a class="text-slate-500 dark:text-slate-400 hover:text-blue-700 dark:hover:text-blue-300 transition-opacity text-sm" href="#">Campus Safety</a>
</div>
<div class="flex flex-col gap-3">
<span class="font-bold uppercase tracking-widest text-[10px] text-slate-900 dark:text-slate-100">Support</span>
<a class="text-slate-500 dark:text-slate-400 hover:text-blue-700 dark:hover:text-blue-300 transition-opacity text-sm" href="<%= ctx %>/adminLogin">Admin Login</a>
<a class="text-slate-500 dark:text-slate-400 hover:text-blue-700 dark:hover:text-blue-300 transition-opacity text-sm" href="#">Contact Support</a>
<a class="text-slate-500 dark:text-slate-400 hover:text-blue-700 dark:hover:text-blue-300 transition-opacity text-sm" href="#">Terms of Service</a>
</div>
</div>
<div class="flex flex-col gap-4">
<span class="font-bold uppercase tracking-widest text-[10px] text-slate-900 dark:text-slate-100">Connect</span>
<div class="flex gap-4">
<button class="w-10 h-10 bg-surface-container rounded-full flex items-center justify-center text-on-surface-variant hover:text-primary transition-colors">
<span class="material-symbols-outlined text-lg" data-icon="share">share</span>
</button>
<button class="w-10 h-10 bg-surface-container rounded-full flex items-center justify-center text-on-surface-variant hover:text-primary transition-colors">
<span class="material-symbols-outlined text-lg" data-icon="mail">mail</span>
</button>
</div>
</div>
</div>
</footer>
</body></html>
