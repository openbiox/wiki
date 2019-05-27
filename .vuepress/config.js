module.exports = {
    base: '/wiki/',
    locales: {
        // 键名是该语言所属的子路径
        // 作为特例，默认语言可以使用 '/' 作为其路径。
        '/en/': {
            lang: 'en-US', // 将会被设置为 <html> 的 lang 属性
            title: 'openbiox',
            description: 'A community-driven bioinformatics innovation collaboration group in China'
        },
        '/': {
            lang: 'zh-CN',
            title: 'openbiox',
            description: '一个由社区驱动的中国生物信息学创新协作组'
        }
    },
    themeConfig: {
        locales: {
            // 键名是该语言所属的子路径
            // 作为特例，默认语言可以使用 '/' 作为其路径。
            '/en/': {
                selectText: 'Languages',
                label: 'English',
                editLinkText: 'Edit this page on GitHub',
                serviceWorker: {
                    updatePopup: {
                        message: "New content is available.",
                        buttonText: "Refresh"
                    }
                },
                nav: [
                    { text: 'Wiki', link: '/' },
                    {
                        text: 'Extra',
                        items: [
                            { text: 'Home', link: 'https://openbiox.org/' },
                            { text: 'Community', link: 'https://community.openbiox.org/' },
                            { text: 'Projects', link: 'https://openbiox.org/projects' },
                        ]
                    }
                ],
                algolia: {},
                sidebar: [
                    {
                        title: 'Introduction',
                        collapsable: true,
                        children: [
                            '/en/declaration/'
                        ]
                    },
                    {
                        title: 'Events and history',
                        collapsable: true,
                        children: [
                        ]
                    },
                    {
                        title: 'Resources',
                        collapsable: true,
                        children: [
                        ]
                    },
                ],
            },
            '/': {
                selectText: '选择语言',
                // 该语言在下拉菜单中的标签
                label: '简体中文',
                // 编辑链接文字
                editLinkText: '在 GitHub 上编辑此页',
                // Service Worker 的配置
                serviceWorker: {
                    updatePopup: {
                        message: "发现新内容可用.",
                        buttonText: "刷新"
                    }
                },
                nav: [
                    { text: 'Wiki', link: '/' },
                    {
                        text: '其他链接',
                        items: [
                            { text: '主页', link: 'https://openbiox.org/' },
                            { text: '社区', link: 'https://community.openbiox.org/' },
                            { text: '项目', link: 'https://openbiox.org/projects' },
                        ]
                    }
                ],
                // 当前 locale 的 algolia docsearch 选项
                algolia: {},
                sidebar: [
                    {
                        title: '简介',
                        collapsable: true,
                        children: [
                            '/declaration/',
                            '/members/'
                        ]
                    },
                    {
                        title: '例行事项及历史事件',
                        collapsable: true,
                        children: [
                            '/events/routine/',
                            '/events/minutes/',
                            '/events/history/',
                            '/events/projects/',
                        ]
                    },
                    {
                        title: '资源池',
                        collapsable: true,
                        children: [
                            '/resources/projects',
                            '/resources/funds',
                            '/resources/device'
                        ]
                    }
                ],
            }
        },

        sidebarDepth: 1,
        activeHeaderLinks: true,
        displayAllHeaders: true,
        repo: 'openbiox/openbiox-wiki',

        lastUpdated: 'Last Updated',
    },
    configureWebpack: {
        resolve: {
            alias: {
                '@': '../'
            }
        }
    }
}
