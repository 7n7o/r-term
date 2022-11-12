# r-term

# Building the project.

Install rojo 7+ and run `rojo build -o CLI.rbxm`

# Running the project.

## From local file

```lua
local rbxmSuite = loadstring(game:HttpGetAsync("https://github.com/richie0866/rbxm-suite/releases/latest/download/rbxm-suite.lua"))()

rbxmSuite.launch("path/to.rbxm", {
	runscripts = true,
	deferred = true,
	nocache = false,
	nocirculardeps = true,
	debug = false,
	verbose = false,
})
```

## From GitHub

```lua
local rbxmSuite = loadstring(game:HttpGetAsync("https://github.com/richie0866/rbxm-suite/releases/latest/download/rbxm-suite.lua"))()

local path = rbxmSuite.download("7n7o/r-term@latest", "CLI.rbxm")
-- Download the latest RBXM
rbxmSuite.launch(path, {
    runscripts=true,
    deferred = true,
    nocirculardeps = true
})
```