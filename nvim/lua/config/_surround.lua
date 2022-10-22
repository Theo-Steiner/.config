-- Custom svelte surroundings for tpope's vim-surround.
-- in visual mode, hit <shift>-s to enter *vS* mode
-- then hit the corresponding asci character to surround with snippet
-- for await scaffolding: asci-97 => a
vim.g.surround_97 = "{#await expression}\r{:then value} {value} {:catch error} {error} {/await}"
-- for each block: asci-101 => e
vim.g.surround_101 = "{#each iterable as value}\r{/each}"
-- for if block: asci-105 =>
vim.g.surround_105 = "{#if condition}\r{/if}"
