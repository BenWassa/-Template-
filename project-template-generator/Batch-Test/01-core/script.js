// Batch-Test - Interactive JavaScript
// Based on Project Ares architecture

document.addEventListener('DOMContentLoaded', function() {
    // Elements
    const navToggle = document.getElementById('nav-toggle');
    const stickyNav = document.getElementById('sticky-nav');
    const backToTop = document.getElementById('back-to-top');
    const progressFill = document.getElementById('progress-fill');

    // Navigation toggle
    if (navToggle && stickyNav) {
        navToggle.addEventListener('click', function() {
            navToggle.classList.toggle('active');
            stickyNav.classList.toggle('active');
        });

        // Close navigation when clicking outside
        document.addEventListener('click', function(event) {
            if (!stickyNav.contains(event.target) && !navToggle.contains(event.target)) {
                navToggle.classList.remove('active');
                stickyNav.classList.remove('active');
            }
        });
    }

    // Scroll progress indicator
    function updateProgressBar() {
        const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        const scrollHeight = document.documentElement.scrollHeight - window.innerHeight;
        const progress = (scrollTop / scrollHeight) * 100;
        
        if (progressFill) {
            progressFill.style.width = Math.min(progress, 100) + '%';
        }
    }

    // Back to top functionality
    function updateBackToTop() {
        const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        
        if (backToTop) {
            if (scrollTop > 300) {
                backToTop.classList.add('visible');
            } else {
                backToTop.classList.remove('visible');
            }
        }
    }

    if (backToTop) {
        backToTop.addEventListener('click', function() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    }

    // Scroll handlers
    window.addEventListener('scroll', function() {
        updateProgressBar();
        updateBackToTop();
    });

    // Smooth scrolling for internal links
    document.querySelectorAll('a[href^="#"]').forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const targetId = this.getAttribute('href').substring(1);
            const targetElement = document.getElementById(targetId);
            
            if (targetElement) {
                const offsetTop = targetElement.offsetTop - 80;
                window.scrollTo({
                    top: offsetTop,
                    behavior: 'smooth'
                });
                
                // Close navigation if open
                if (navToggle && stickyNav) {
                    navToggle.classList.remove('active');
                    stickyNav.classList.remove('active');
                }
            }
        });
    });

    // Keyboard navigation
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            if (navToggle && stickyNav) {
                navToggle.classList.remove('active');
                stickyNav.classList.remove('active');
            }
        }
    });

    // Initialize
    updateProgressBar();
    updateBackToTop();
    
    console.log('Batch-Test initialized successfully');
});