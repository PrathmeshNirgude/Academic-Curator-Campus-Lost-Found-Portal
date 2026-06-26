<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.lostfound.model.User" %>
<%
    String ctx = request.getContextPath();
    User loggedUser = (User) session.getAttribute("loggedUser");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Report an Item - The Academic Curator</title>
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
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; vertical-align: middle; }
        .editorial-title { letter-spacing: -0.02em; }
        .ghost-border { border-bottom: 2px solid rgba(195, 198, 215, 0.2); transition: border-color 0.2s ease; }
        .ghost-border:focus-within { border-color: #004ac6; }
        body { font-family: 'Inter', sans-serif; }
    </style>
</head>
<body class="bg-surface text-on-surface min-h-screen flex flex-col">
<!-- TopNavBar -->
<nav class="bg-slate-50/80 backdrop-blur-xl dark:bg-slate-950/80 shadow-sm dark:shadow-none docked full-width top-0 sticky z-50">
<div class="flex justify-between items-center w-full px-8 py-4 max-w-7xl mx-auto">
<a href="<%= ctx %>/" class="text-2xl font-bold tracking-tighter text-blue-700 dark:text-blue-500">The Academic Curator</a>
<div class="hidden md:flex gap-8 items-center">
<a class="text-slate-500 dark:text-slate-400 font-medium hover:text-blue-500 dark:hover:text-blue-300 transition-colors text-xs uppercase tracking-widest Inter" href="<%= ctx %>/items">Browse</a>
<a class="text-blue-600 dark:text-blue-400 border-b-2 border-blue-600 pb-1 font-semibold transition-all duration-200 text-xs uppercase tracking-widest Inter" href="<%= ctx %>/reportItem">Report</a>
<a class="text-slate-500 dark:text-slate-400 font-medium hover:text-blue-500 dark:hover:text-blue-300 transition-colors text-xs uppercase tracking-widest Inter" href="<%= ctx %>/myItems">My Items</a>
</div>
<div class="flex items-center gap-4">
<a href="<%= ctx %>/logout" title="Logout" class="material-symbols-outlined text-on-surface-variant hover:text-error transition-colors" data-icon="logout">logout</a>
</div>
</div>
</nav>

<main class="flex-grow flex flex-col items-center px-6 py-12 bg-surface-container-low">
<!-- Editorial Header -->
<div class="max-w-3xl w-full mb-12 text-center">
<span class="text-[10px] font-bold uppercase tracking-widest text-primary mb-3 block">Digital Concierge</span>
<h1 class="text-5xl font-extrabold editorial-title text-on-surface mb-4">Report an Item</h1>
<p class="text-on-surface-variant max-w-xl mx-auto leading-relaxed">Whether you've lost a personal artifact or found something that needs returning, our curated process ensures it finds its way home.</p>
</div>

<!-- Centered Form Card -->
<div class="max-w-3xl w-full bg-surface-container-lowest rounded-xl shadow-sm overflow-hidden p-10 border border-outline-variant/10">

<% if (error != null) { %>
    <div class="mb-8 p-4 bg-error-container/30 text-on-error-container font-medium rounded-xl flex items-center gap-2 border border-error-container">
        <span class="material-symbols-outlined font-bold">error</span>
        <%= error %>
    </div>
<% } %>
<div id="alert-container"></div>

<form id="reportForm" action="<%= ctx %>/reportItem" method="post" enctype="multipart/form-data" onsubmit="return validateForm('reportForm')" class="space-y-10">
<!-- Toggle: Lost vs Found -->
<div class="flex flex-col space-y-4">
<label class="font-bold uppercase tracking-widest text-[10px] text-on-surface-variant">Transaction Type <span class="text-error">*</span></label>
<div class="grid grid-cols-2 gap-4">
    <label class="cursor-pointer relative">
        <input type="radio" name="type" id="typeFound" value="found" class="peer sr-only" required>
        <div class="flex items-center justify-center gap-3 py-4 px-6 bg-surface-container-high text-on-surface-variant rounded-xl peer-checked:bg-primary peer-checked:text-on-primary peer-checked:shadow-lg peer-checked:shadow-primary/20 transition-all duration-200">
            <span class="material-symbols-outlined" data-icon="inventory_2" style="font-variation-settings: 'FILL' 1;">inventory_2</span>
            <span class="font-semibold">I Found Something</span>
        </div>
    </label>
    <label class="cursor-pointer relative">
        <input type="radio" name="type" id="typeLost" value="lost" class="peer sr-only" checked required>
        <div class="flex items-center justify-center gap-3 py-4 px-6 bg-surface-container-high text-on-surface-variant rounded-xl peer-checked:bg-error peer-checked:text-white peer-checked:shadow-lg peer-checked:shadow-error/20 transition-all duration-200">
            <span class="material-symbols-outlined" data-icon="search">search</span>
            <span class="font-semibold">I Lost Something</span>
        </div>
    </label>
</div>
</div>

<!-- Form Fields Grid -->
<div class="grid grid-cols-1 md:grid-cols-2 gap-x-10 gap-y-8">
<!-- Item Title -->
<div class="flex flex-col space-y-2 ghost-border">
<label class="font-bold uppercase tracking-widest text-[10px] text-primary" for="title">Item Title <span class="text-error">*</span></label>
<input id="title" name="title" class="w-full bg-transparent border-none p-0 focus:ring-0 text-on-surface placeholder:text-outline/40 font-medium" placeholder="e.g., Black Leather Portfolio" type="text" required maxlength="150" />
</div>

<!-- Category Dropdown -->
<div class="flex flex-col space-y-2 ghost-border">
<label class="font-bold uppercase tracking-widest text-[10px] text-primary" for="category">Category <span class="text-error">*</span></label>
<select id="category" name="category" class="w-full bg-transparent border-none p-0 focus:ring-0 text-on-surface appearance-none cursor-pointer font-medium" required>
<option value="">Select Category</option>
<option value="Electronics">Electronics</option>
<option value="Books">Books &amp; Stationery</option>
<option value="ID Card">ID / Cards</option>
<option value="Clothing">Clothing</option>
<option value="Bags">Bags &amp; Accessories</option>
<option value="Keys">Keys</option>
<option value="Wallet">Wallet / Money</option>
<option value="Other">Other</option>
</select>
</div>

<!-- Date Picker -->
<div class="flex flex-col space-y-2 ghost-border">
<label class="font-bold uppercase tracking-widest text-[10px] text-primary" for="dateReported">Date Discovered <span class="text-error">*</span></label>
<div class="flex items-center">
<input id="dateReported" name="dateReported" class="w-full bg-transparent border-none p-0 focus:ring-0 text-on-surface font-medium cursor-text" type="date" required max="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" />
</div>
</div>

<!-- Location -->
<div class="flex flex-col space-y-2 ghost-border">
<label class="font-bold uppercase tracking-widest text-[10px] text-primary" for="location">Location <span class="text-error">*</span></label>
<div class="flex items-center gap-2">
<span class="material-symbols-outlined text-outline" data-icon="location_on">location_on</span>
<input id="location" name="location" class="w-full bg-transparent border-none p-0 focus:ring-0 text-on-surface placeholder:text-outline/40 font-medium" placeholder="e.g., Sterling Library, Room 204" type="text" required maxlength="100" />
</div>
</div>

<!-- Description -->
<div class="flex flex-col space-y-2 ghost-border md:col-span-2">
<label class="font-bold uppercase tracking-widest text-[10px] text-primary" for="description">Detailed Description</label>
<textarea id="description" name="description" class="w-full bg-transparent border-none p-0 focus:ring-0 text-on-surface placeholder:text-outline/40 leading-relaxed font-medium resize-none" placeholder="Describe unique features, scratches, or contents inside..." rows="3"></textarea>
</div>
</div>

<!-- Upload Photo Area -->
<div class="flex flex-col space-y-4">
<label class="font-bold uppercase tracking-widest text-[10px] text-on-surface-variant">Visual Verification (Optional)</label>
<div id="dropZone" class="group relative flex flex-col items-center justify-center border-2 border-dashed border-outline-variant/30 rounded-xl p-12 bg-surface-container-low hover:bg-surface-container transition-colors cursor-pointer" onclick="document.getElementById('image').click()">
<div class="w-16 h-16 bg-white shadow-sm rounded-full flex items-center justify-center mb-4 group-hover:scale-110 transition-transform" id="imageIcon">
<span class="material-symbols-outlined text-primary text-3xl" data-icon="add_a_photo">add_a_photo</span>
</div>
<p class="font-semibold text-on-surface" id="imageText">Upload a high-resolution photo</p>
<p class="text-sm text-on-surface-variant mt-1" id="imageSubtext">Drag and drop or click to browse (Max 5MB)</p>
<img id="imagePreview" src="" alt="Preview" style="display:none; width: 100%; max-height: 200px; object-fit: cover; border-radius: 8px; margin-top: 1rem;">
</div>
<input type="file" id="image" name="image" accept="image/*" style="display:none" onchange="previewImage('image','imagePreview')">
<script>
    const dropZone = document.getElementById('dropZone');
    const fileInput = document.getElementById('image');

    // Prevent default drag behaviors
    ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
        dropZone.addEventListener(eventName, preventDefaults, false);
    });

    function preventDefaults(e) {
        e.preventDefault();
        e.stopPropagation();
    }

    // Highlight drop zone when item is dragged over it
    ['dragenter', 'dragover'].forEach(eventName => {
        dropZone.addEventListener(eventName, () => dropZone.classList.add('border-primary', 'bg-surface-container'), false);
    });

    ['dragleave', 'drop'].forEach(eventName => {
        dropZone.addEventListener(eventName, () => dropZone.classList.remove('border-primary', 'bg-surface-container'), false);
    });

    // Handle dropped files
    dropZone.addEventListener('drop', (e) => {
        const dt = e.dataTransfer;
        const files = dt.files;
        if (files && files.length > 0) {
            fileInput.files = files; // Assign files to the hidden input
            previewImage('image', 'imagePreview'); // Trigger preview
        }
    });

    window.previewImage = function(inputId, previewId) {
        const input = document.getElementById(inputId);
        if(input && input.files && input.files[0]) {
            document.getElementById('imageIcon').style.display = 'none';
            document.getElementById('imageText').style.display = 'none';
            document.getElementById('imageSubtext').style.display = 'none';
            
            const preview = document.getElementById(previewId);
            const reader = new FileReader();
            reader.onload = function(e) {
                 preview.src = e.target.result;
                 preview.style.display = 'block';
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
</div>

<!-- Submit Button -->
<div class="pt-6">
<button class="w-full py-5 bg-gradient-to-r from-primary to-primary-container text-on-primary font-bold text-lg rounded-xl shadow-lg shadow-primary/20 hover:brightness-105 active:scale-[0.98] transition-all flex items-center justify-center gap-3" type="submit">
<span class="material-symbols-outlined" data-icon="send">send</span>
                        Submit Report
                    </button>
<p class="text-center text-xs text-on-surface-variant mt-4 italic">By submitting, you agree to our Campus Safety &amp; Privacy Guidelines.</p>
</div>
</form>
</div>

</main>
<!-- Footer -->
<footer class="bg-white dark:bg-slate-900 w-full py-12 mt-auto border-t border-surface-container-high">
<div class="flex flex-col md:flex-row justify-between items-start px-12 max-w-7xl mx-auto gap-8">
<div class="max-w-md">
<div class="text-xl font-bold text-slate-900 dark:text-slate-100 mb-4">The Academic Curator</div>
<p class="text-sm Inter text-slate-500 dark:text-slate-400 leading-relaxed">© 2026 The Academic Curator. Elevating campus lost &amp; found to a digital concierge experience.</p>
</div>
<div class="grid grid-cols-2 gap-x-12 gap-y-4">
<a class="text-slate-500 dark:text-slate-400 hover:text-blue-700 dark:hover:text-blue-300 transition-opacity text-sm" href="#">Privacy Policy</a>
<a class="text-slate-500 dark:text-slate-400 hover:text-blue-700 dark:hover:text-blue-300 transition-opacity text-sm" href="#">Campus Safety</a>
<a class="text-slate-500 dark:text-slate-400 hover:text-blue-700 dark:hover:text-blue-300 transition-opacity text-sm" href="<%= ctx %>/adminLogin">Admin Login</a>
<a class="text-slate-500 dark:text-slate-400 hover:text-blue-700 dark:hover:text-blue-300 transition-opacity text-sm" href="#">Terms of Service</a>
</div>
</div>
</footer>
<script src="<%= ctx %>/js/main.js"></script>
</body></html>
