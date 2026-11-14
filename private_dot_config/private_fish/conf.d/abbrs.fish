abbr -a -- c cd
abbr -a -- l ls
abbr -a -- la ls -al
abbr -a -- v nvim
abbr -a -- n nvim
abbr -a -- nv nvim
abbr -a -- nn nvim
abbr -a -- vi nvim
abbr -a -- pp pnpm
abbr -a -- pe pnpm exec

abbr -a -- tf terraform
abbr -a -- tfi terraform init
abbr -a -- tfp terraform plan
abbr -a -- tfa terraform apply

abbr -a -- g git
abbr -a -- gs git status
abbr -a -- gd git diff
abbr -a -- gpm "git checkout main && git pull"
abbr -a -- gpb "prunebranch && git trim"
abbr -c git co checkout

abbr -a -- lg lazygit

abbr -a -- che chezmoi
abbr -a -- ccd chezmoi cd

abbr -a -- pgd pg_dump
abbr -a -- pgr pg_restore

abbr -a -- do doctl
abbr -a -- doa doctl auth
abbr -a -- doi doctl invoice
abbr -c doctl a auth
abbr -c doctl i invoice

abbr -a -- tt task
abbr -a -- tk task
abbr -a -- avo aws-vault

abbr -a -- jqr jq_preview
abbr -a -- jqp jq_preview

abbr -a -- emu "doom upgrade && doom sync && brew services restart emacs-plus"
abbr -a -- emsr "brew services restart emacs-plus"

abbr -a -- qq 'npx quartz'
abbr -a -c npx -c quartz -- s sync
abbr -a -c npx -c quartz -- b build
abbr -a -c npx -c quartz -- p plugin
abbr -a -c npx -c quartz -- pa 'plugin add'
abbr -a -c npx -c quartz -- pr 'plugin remove'
abbr -a -c npx -c quartz -- pi 'plugin install'
