<!DOCTYPE html>
<html lang="en">

<head>

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


    <meta charset="utf-8">
    <meta http-equiv="Content-Language" content="en">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Theme Switcher | Basecoat</title>
    <link rel="stylesheet" href="https://basecoatui.com/assets/styles.css">
    <script src="https://basecoatui.com//assets/js/basecoat.js" defer></script>
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
</head>

<body>
    <aside id="sidebar" class="sidebar " data-side="left" aria-hidden="false">
        <nav aria-label="Sidebar navigation">
            <header>
                <a href="/" class="btn-ghost p-2 h-12 w-full justify-start">
                    <div
                        class="bg-sidebar-primary text-sidebar-primary-foreground flex aspect-square size-8 items-center justify-center rounded-lg">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 256" class="h-4 w-4">
                            <rect width="256" height="256" fill="none"></rect>
                            <line x1="208" y1="128" x2="128" y2="208" fill="none" stroke="currentColor"
                                stroke-linecap="round" stroke-linejoin="round" stroke-width="32"></line>
                            <line x1="192" y1="40" x2="40" y2="192" fill="none" stroke="currentColor"
                                stroke-linecap="round" stroke-linejoin="round" stroke-width="32"></line>
                        </svg>
                    </div>
                    <div class="grid flex-1 text-left text-sm leading-tight">
                        <span class="truncate font-medium">Basecoat</span>
                        <span class="truncate text-xs">v0.3.2</span>
                    </div>
                </a>
            </header>
            <section class="scrollbar">
                <div role="group" aria-labelledby="group-label-sidebar-content-2">
                    <h3 id="group-label-sidebar-content-2">Pages</h3>
                    <ul class="nav-list">
                        <li>
                            <a href="negara" hx-boost="true" hx-select="#content" hx-target="#content"
                                hx-swap="outerHTML">
                                <span>CRUD ABCD</span>
                            </a>
                        </li>
                    </ul>
                </div>
                <div role="group" aria-labelledby="group-label-sidebar-content-2">
                    <h3 id="group-label-sidebar-content-2 mt-4">Administrator</h3>
                    <ul class="nav-list">
                        <li>
                            <a href="${pageContext.request.contextPath}/company" hx-boost="true" hx-select="#content"
                                hx-target="#content" hx-swap="outerHTML">
                                <!--<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-factory-icon lucide-factory"><path d="M12 16h.01"/><path d="M16 16h.01"/><path d="M3 19a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V8.5a.5.5 0 0 0-.769-.422l-4.462 2.844A.5.5 0 0 1 15 10.5v-2a.5.5 0 0 0-.769-.422L9.77 10.922A.5.5 0 0 1 9 10.5V5a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2z"/><path d="M8 16h.01"/></svg>-->
                                <span>Company</span>
                                <!--<span class="badge-destructive">restricted</span>-->
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/factory" hx-boost="true" hx-select="#content"
                                hx-target="#content" hx-swap="outerHTML">
                                <!--<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-building2-icon lucide-building-2"><path d="M10 12h4"/><path d="M10 8h4"/><path d="M14 21v-3a2 2 0 0 0-4 0v3"/><path d="M6 10H4a2 2 0 0 0-2 2v7a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2h-2"/><path d="M6 21V5a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v16"/></svg>-->
                                <span>Factory</span>
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/department" hx-boost="true" hx-select="#content"
                                hx-target="#content" hx-swap="outerHTML">
                                <!--<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-hotel-icon lucide-hotel"><path d="M10 22v-6.57"/><path d="M12 11h.01"/><path d="M12 7h.01"/><path d="M14 15.43V22"/><path d="M15 16a5 5 0 0 0-6 0"/><path d="M16 11h.01"/><path d="M16 7h.01"/><path d="M8 11h.01"/><path d="M8 7h.01"/><rect x="4" y="2" width="16" height="20" rx="2"/></svg>-->
                                <span>Department</span>
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/division" hx-boost="true" hx-select="#content"
                                hx-target="#content" hx-swap="outerHTML">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                    fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round" class="lucide lucide-blocks-icon lucide-blocks">
                                    <path
                                        d="M10 22V7a1 1 0 0 0-1-1H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-5a1 1 0 0 0-1-1H2" />
                                    <rect x="14" y="2" width="8" height="8" rx="1" />
                                </svg>
                                <span>Division</span>
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/user" hx-boost="true" hx-select="#content"
                                hx-target="#content" hx-swap="outerHTML">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                    fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round" class="lucide lucide-users-icon lucide-users">
                                    <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2" />
                                    <path d="M16 3.128a4 4 0 0 1 0 7.744" />
                                    <path d="M22 21v-2a4 4 0 0 0-3-3.87" />
                                    <circle cx="9" cy="7" r="4" />
                                </svg>
                                <span>Users</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </section>
            <footer>
                <div id="popover-852113" class="popover ">
                    <button id="popover-852113-trigger" type="button" aria-expanded="false"
                        aria-controls="popover-852113-popover"
                        class="btn-ghost p-2 h-12 w-full flex items-center justify-start"
                        data-keep-mobile-sidebar-open="">
                        <img src="https://avatars.githubusercontent.com/u/9919?v=4" class="rounded-lg shrink-0 size-8">
                        <div class="grid flex-1 text-left text-sm leading-tight">
                            <span class="truncate font-medium">Ronan Berder</span>
                            <span class="truncate text-xs">@hunvreus</span>
                        </div>
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="m7 15 5 5 5-5" />
                            <path d="m7 9 5-5 5 5" />
                        </svg>
                    </button>
                    <div id="popover-852113-popover" data-popover aria-hidden="true" data-side="top"
                        class="w-[271px] md:w-[239px]">
                        <div class="grid gap-4">
                            <header class="grid gap-1.5">
                                <h2 class="font-semibold">I hope you like Basecoat...</h2>
                                <p class="text-muted-foreground text-sm">My name is <a href="https://ronanberder.com"
                                        target="_blank">Ronan</a> and I made this (and <a
                                        class="underline underline-offset-4" href="https://pagescms.org"
                                        target="_target">other things</a>). If you find it useful, please consider
                                    sponsoring me on GitHub or following me on X.</p>
                            </header>
                            <footer class="grid gap-2">
                                <a href="https://github.com/sponsors/hunvreus" class="btn-sm" target="_blank">Sponsor me
                                    on GitHub</a>
                                <a href="https://x.com/hunvreus" class="btn-sm-outline" target="_blank">Follow me on
                                    X</a>
                            </footer>
                        </div>
                    </div>
                </div>
            </footer>
        </nav>
    </aside>
    <main id="content">
        <header class="bg-background sticky inset-x-0 top-0 isolate flex shrink-0 items-center gap-2 border-b z-10">
            <div class="flex h-14 w-full items-center gap-2 px-4">
                <button type="button" onclick="document.dispatchEvent(new CustomEvent('basecoat:sidebar'))"
                    aria-label="Toggle sidebar" data-tooltip="Toggle sidebar" data-side="bottom" data-align="start"
                    class="btn-sm-icon-ghost mr-auto size-7 -ml-1.5">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <rect width="18" height="18" x="3" y="3" rx="2" />
                        <path d="M9 3v18" />
                    </svg>
                </button><select class="select h-8 leading-none theme-select">
                    <option value="">Default</option>
                    <option value="claude">Claude</option>
                    <option value="doom-64">Doom 64</option>
                    <option value="supabase">Supabase</option>
                </select>

                <select class="select h-8 leading-none theme-select">
                    <option value="">Default</option>
                    <option value="claude">Claude</option>
                    <option value="doom-64">Doom 64</option>
                    <option value="supabase">Supabase</option>
                </select>

                <script>
                    (function () {
                        const THEME_KEY = 'theme';            // khusus nama tema UI (claude/doom-64/supabase)
                        const THEME_PREFIX = 'theme-';        // prefix class di <html>
                        const selects = () => Array.from(document.querySelectorAll('.theme-select'));
                        const html = document.documentElement;

                        // Hapus semua class yang diawali "theme-" tanpa ganggu class lain (mis. 'dark')
                        function clearThemeClasses() {
                            html.classList.forEach(c => {
                                if (c.startsWith(THEME_PREFIX)) html.classList.remove(c);
                            });
                        }

                        // Terapkan tema baru ('' = default)
                        function applyTheme(name) {
                            clearThemeClasses();
                            if (name) html.classList.add(THEME_PREFIX + name);
                            try {
                                if (name) localStorage.setItem(THEME_KEY, name);
                                else localStorage.removeItem(THEME_KEY);
                            } catch (_) { }
                            // Sinkronkan nilai semua dropdown
                            selects().forEach(sel => { sel.value = name || ''; });
                        }

                        // Init awal dari localStorage
                        const saved = (() => {
                            try { return localStorage.getItem(THEME_KEY) || ''; } catch (_) { return ''; }
                        })();
                        applyTheme(saved);

                        // Pasang listener ke SEMUA select
                        function attachListeners() {
                            selects().forEach(sel => {
                                // Hindari multiple binding kalau dipanggil ulang
                                if (sel._themeBound) return;
                                sel._themeBound = true;

                                sel.addEventListener('change', (e) => {
                                    const val = e.target.value;
                                    applyTheme(val);
                                });
                            });
                        }
                        attachListeners();

                        // HTMX: setelah swap, re-attach listener & sync value dropdown baru
                        document.addEventListener('htmx:afterSwap', () => {
                            attachListeners();
                            // Pastikan <select> baru ikut terset nilainya
                            const current = (() => {
                                try { return localStorage.getItem(THEME_KEY) || ''; } catch (_) { return ''; }
                            })();
                            selects().forEach(sel => { sel.value = current; });
                        });
                    })();
                </script>


                <button type="button" aria-label="Toggle dark mode" data-tooltip="Toggle dark mode" data-side="bottom"
                    onclick="document.dispatchEvent(new CustomEvent('basecoat:theme'))" class="btn-icon-outline size-8">
                    <span class="hidden dark:block"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                            viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                            stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="12" cy="12" r="4" />
                            <path d="M12 2v2" />
                            <path d="M12 20v2" />
                            <path d="m4.93 4.93 1.41 1.41" />
                            <path d="m17.66 17.66 1.41 1.41" />
                            <path d="M2 12h2" />
                            <path d="M20 12h2" />
                            <path d="m6.34 17.66-1.41 1.41" />
                            <path d="m19.07 4.93-1.41 1.41" />
                        </svg></span>
                    <span class="block dark:hidden"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                            viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                            stroke-linecap="round" stroke-linejoin="round">
                            <path d="M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z" />
                        </svg></span>
                </button>
                <a href="https://google.com" class="btn-icon size-8" target="_blank" rel="noopener noreferrer"
                    data-tooltip="GitHub repository" data-side="bottom" data-align="end">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path
                            d="M15 22v-4a4.8 4.8 0 0 0-1-3.5c3 0 6-2 6-5.5.08-1.25-.27-2.48-1-3.5.28-1.15.28-2.35 0-3.5 0 0-1 0-3 1.5-2.64-.5-5.36-.5-8 0C6 2 5 2 5 2c-.3 1.15-.3 2.35 0 3.5A5.403 5.403 0 0 0 4 9c0 3.5 3 5.5 6 5.5-.39.49-.68 1.05-.85 1.65-.17.6-.22 1.23-.15 1.85v4" />
                        <path d="M9 18c-4.51 2-5-2-7-2" />
                    </svg>
                </a>
            </div>
        </header>
        <div class="p-4 md:p-6 xl:p-12">
            <main class="mx-auto relative flex w-full max-w-screen-lg gap-10">
                <div class="mx-auto w-full flex-1 max-w-screen-md">
                    <header class="space-y-2">
                        <h1 class="text-2xl font-semibold tracking-tight sm:text-3xl xl:text-4xl">Theme Switcher</h1>
                        <p class="text-muted-foreground text-[1.05rem] sm:text-base">A component that allows the user to
                            switch between light and dark mode.</p>
                    </header>
                    <article class="pb-12 mt-8 content">
                        <h1> Section Left</h1>
                    </article>
                </div>
                <div class="hidden text-sm xl:block w-full max-w-[300px]">
                    <nav
                        class="sticky top-22 space-y-2 [&_ul]:m-0 [&_ul]:list-none [&_ul_ul]:pl-4 [&_li]:mt-0 [&_li]:pt-2 [&_a]:inline-block [&_a]:no-underline [&_a]:transition-colors [&_a]:hover:text-foreground [&_a]:text-muted-foreground">
                        <h4 class="font-medium">On This Page</h4>
                        <h1> Section right</h1>
                    </nav>
                </div>
            </main>
        </div>
    </main>
    <div id="toaster" class="toaster ">
    </div>
</body>

</html>