<script>
    (() => {
        try {
            const stored = localStorage.getItem('themeMode');
            if (stored ? stored === 'dark'
                : matchMedia('(prefers-color-scheme: dark)').matches) {
                document.documentElement.classList.add('dark');
            }
        } catch (_) { }

        const apply = dark => {
            document.documentElement.classList.toggle('dark', dark);
            try { localStorage.setItem('themeMode', dark ? 'dark' : 'light'); } catch (_) { }
        };

        document.addEventListener('basecoat:theme', (event) => {
            const mode = event.detail?.mode;
            apply(mode === 'dark' ? true
                : mode === 'light' ? false
                    : !document.documentElement.classList.contains('dark'));
        });
    })();
</script>

<script>
    (function () {
        try {
            const storedTheme = localStorage.getItem('themeVariant');
            if (storedTheme) document.documentElement.classList.add(`theme-${storedTheme}`);
        } catch (event) {
            console.error('Could not apply theme variant from localStorage', event);
        }
    })();
</script>


<link rel="icon" type="image/svg+xml" href="https://basecoatui.com/assets/favicon.svg">
<link rel="apple-touch-icon" sizes="180x180" href="/assets/apple-touch-icon.png">

<meta property="og:type" content="website">
<meta property="og:url" content="https://basecoatui.com/components/theme-switcher/">
<meta property="og:title" content="Theme Switcher | Basecoat">
<meta property="og:description" content="A component that allows the user to switch between light and dark mode.">
<meta property="og:image" content="https://basecoatui.com/assets/social-screenshot.png">
<meta property="og:site_name" content="Basecoat">
<meta property="og:locale" content="en_US">
<meta property="og:author" content="Ronan Berder">

<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:url" content="https://basecoatui.com/components/theme-switcher/">
<meta name="twitter:title" content="Theme Switcher">
<meta name="twitter:description" content="A component that allows the user to switch between light and dark mode.">
<meta name="twitter:image" content="https://basecoatui.com/assets/social-screenshot.png">
<meta name="twitter:creator" content="@hunvreus">

<link rel="stylesheet" href="https://basecoatui.com//assets/styles.css">

<script src="https://basecoatui.com/assets/js/basecoat.js" defer></script>
<script src="https://basecoatui.com/assets/js/dropdown-menu.js" defer></script>
<script src="https://basecoatui.com/assets/js/popover.js" defer></script>
<script src="https://basecoatui.com/assets/js/select.js" defer></script>
<script src="https://basecoatui.com/assets/js/sidebar.js" defer></script>
<script src="https://basecoatui.com/assets/js/tabs.js" defer></script>
<script src="https://basecoatui.com/assets/js/toast.js" defer></script>

<script src="https://unpkg.com/htmx.org@2.0.4"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/languages/django.min.js"></script>
<script>
    const highlight = () => {
        if (!window.hljs) return;
        document
            .querySelectorAll('pre code:not([data-highlighted]), code.highlight:not([data-highlighted])')
            .forEach(el => hljs.highlightElement(el));
    };

    if (!window._hljsInit) {
        window._hljsInit = true;
        document.addEventListener('DOMContentLoaded', highlight);
        document.addEventListener('htmx:afterSwap', highlight);
    }
</script>
<script>
    document.addEventListener('htmx:historyRestore', () => {
        if (window.basecoat) window.basecoat.initAll();
        if (window.Alpine) Alpine.initTree(document.body);
    });
</script>