// ===== LOST & FOUND PORTAL - MAIN JS =====

// Tab switching
function switchTab(tabId) {
    document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
    document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
    document.getElementById(tabId).classList.add('active');
    event.target.classList.add('active');
}

// Modal open/close
function openModal(id) {
    document.getElementById(id).classList.add('show');
    document.body.style.overflow = 'hidden';
}

function closeModal(id) {
    document.getElementById(id).classList.remove('show');
    document.body.style.overflow = '';
}

// Close modal on backdrop click
document.addEventListener('click', function(e) {
    if (e.target.classList.contains('modal-backdrop')) {
        e.target.classList.remove('show');
        document.body.style.overflow = '';
    }
});

// Image preview on file select
function previewImage(inputId, previewId) {
    const input = document.getElementById(inputId);
    const preview = document.getElementById(previewId);
    if (input && preview && input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = e => {
            preview.src = e.target.result;
            preview.style.display = 'block';
        };
        reader.readAsDataURL(input.files[0]);
    }
}

// Form validation
function validateForm(formId) {
    const form = document.getElementById(formId);
    if (!form) return true;

    let valid = true;
    form.querySelectorAll('[required]').forEach(field => {
        field.classList.remove('is-invalid');
        if (!field.value.trim()) {
            field.classList.add('is-invalid');
            valid = false;
        }
    });

    // Email validation
    const emailField = form.querySelector('input[type="email"]');
    if (emailField && emailField.value) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(emailField.value)) {
            emailField.classList.add('is-invalid');
            valid = false;
        }
    }

    // Phone validation
    const phoneField = form.querySelector('input[name="phone"]');
    if (phoneField && phoneField.value) {
        const phoneRegex = /^[0-9]{10}$/;
        if (!phoneRegex.test(phoneField.value.trim())) {
            phoneField.classList.add('is-invalid');
            showAlert('Phone number must be 10 digits.', 'danger');
            valid = false;
        }
    }

    if (!valid) {
        showAlert('Please fill all required fields correctly.', 'danger');
    }
    return valid;
}

// Show inline alert
function showAlert(msg, type = 'info') {
    const container = document.getElementById('alert-container');
    if (!container) return;
    container.innerHTML = `
        <div class="alert alert-${type}">
            <span>${type === 'success' ? '✅' : type === 'danger' ? '❌' : 'ℹ️'}</span>
            <span>${msg}</span>
        </div>`;
    setTimeout(() => { container.innerHTML = ''; }, 5000);
}

// Confirm delete
function confirmDelete(url, name) {
    if (confirm(`Are you sure you want to delete "${name}"? This cannot be undone.`)) {
        window.location.href = url;
    }
}

// Auto-dismiss alerts after 4s
document.addEventListener('DOMContentLoaded', function() {
    const alerts = document.querySelectorAll('.alert[data-autohide]');
    alerts.forEach(alert => {
        setTimeout(() => {
            alert.style.opacity = '0';
            alert.style.transition = 'opacity 0.5s';
            setTimeout(() => alert.remove(), 500);
        }, 4000);
    });

    // Activate first tab by default
    const firstTab = document.querySelector('.tab-btn');
    const firstContent = document.querySelector('.tab-content');
    if (firstTab && !document.querySelector('.tab-btn.active')) {
        firstTab.classList.add('active');
    }
    if (firstContent && !document.querySelector('.tab-content.active')) {
        firstContent.classList.add('active');
    }

    // Highlight current nav link
    const currentPath = window.location.pathname;
    document.querySelectorAll('.nav-link').forEach(link => {
        if (link.getAttribute('href') && currentPath.includes(link.getAttribute('href').split('?')[0])) {
            link.classList.add('active');
        }
    });
});
