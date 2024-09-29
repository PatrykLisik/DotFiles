local ls = require("luasnip")
return {
    -- To return multiple snippets, use one `return` statement per snippet file
    -- and return a table of Lua snippets.
    ls.snippet(
        "main",
        { ls.text_node({
            "def main():",
            "    print(\"Hello World!\")",
            "",
            "",
            "if __name__ == \"__main__\":",
            "    main()",
        }) }
    ),
    ls.snippet(
        "async_main",
        { ls.text_node({
            "import asyncio",
            "",
            "",
            "async def main():",
            "    print('done!')",
            "",
            "",
            "if __name__ ==  '__main__':",
            "    loop = asyncio.get_event_loop()",
            "    loop.run_until_complete(main())",
            ""
        }) }
    ),
}
