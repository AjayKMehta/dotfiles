-- https://ohmyposh.dev/docs/installation/prompt

local conda_theme = os.getenv("POSH_THEMES_PATH") .. "tonybaloney.omp.json"
local regular_theme = os.getenv("POSH_THEMES_PATH") .. "negligible.omp.json"

-- Choose theme based on whether CONDA_PREFIX is set
local theme = os.getenv("CONDA_PREFIX") == nil and regular_theme or conda_theme
print(theme)
load(io.popen('oh-my-posh init cmd -c="' .. theme ..'"'):read("*a"))()
