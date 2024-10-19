#!/usr/bin/env fish

function install-lsps
	set binaryHome /usr/local/bin

	if set -q $XDG_DATA_HOME; then
		set dataHome $XDG_DATA_HOME/.local/share
	else
		set dataHome $HOME/.local/share
	end

	echo "Installing Language Servers for Helix Editor:"
	
	# Temp dir so not to pollute
	set tempDir "/tmp/install-lsps"
	mkdir -p $tempDir
	pushd $tempDir

	# Bash
	echo "  • Bash (bash-language-server)"
	npm i -g bash-language-server

	# HTML, JSON, JSON Schema
	echo "  • HTML, JSON, and JSON schema (vscode-langservers-extracted)"
	npm i -g vscode-langservers-extracted

	# Emmet Snippets
	echo "  • Emmet Completions (emmet-ls)"
	npm i -g emmet-ls

	# JavaScript (via TypeScript)
	echo "  • JavaScript (typescript, typescript-language-server)"
	npm install -g typescript typescript-language-server

	# Astro
	echo "  • Astro (@astrojs/language-server)"
	npm install -g @astrojs/language-server

	# GraphQL
	echo "  • GraphQL (graphql-language-service-cli)"
	npm i -g graphql-language-service-cli

	# Docker
	echo "  • Docker (dockerfile-language-server-nodejs)"
	npm install -g dockerfile-language-server-nodejs

	# Lua
	echo "  • Lua (lua-language-server)"
	brew install lua-language-server

	# Markdown
	echo "  • Markdown (marksman)"

	# Rust
	echo "  • Rust (rust-analyzer)"
	rustup component add rust-analyzer

	# Go
	echo "  • Go (gopls, delve, goimports)"
	go install golang.org/x/tools/gopls@latest          # LSP
	go install github.com/go-delve/delve/cmd/dlv@latest # Debugger
	go install golang.org/x/tools/cmd/goimports@latest  # Formatter

	# PHP
	echo "  • PHP (phpactor)"
	curl -Lo phpactor.phar https://github.com/phpactor/phpactor/releases/latest/download/phpactor.phar
	chmod a+x phactor.phar
	mv ~/.local/bin/phpactor

	# Python
	echo "  • Python (pyright, ruff, black)"
	npm install -g pyright
	pip install ruff-lsp
	pip install black

	# SQL
	echo "  • SQL (sql-language-server)"
	npm i -g sql-language-server

	# YAML
	echo "  • YAML (yaml-language-server)"
	brew install yaml-language-server

	# TOML
	cargo install taplo-cli --locked --features lsp

	# Markdown (via ltex-ls. Note: this has excellent features like
	# spelling and grammar check but is a ~269MB download).
	echo "  • Markdown (marksman, ltex-ls)"
	brew install marksman
	set ltexLsVersion 16.0.0
	set ltexLsBinaryPath $binaryHome/ltex-ls
	set ltexLsBaseFileName ltex-ls-$ltexLsVersion
	set ltexLsFileNameWithPlatform $ltexLsBaseFileName-mac-x64
	set ltexLsAppDirectory $dataHome/$ltexLsBaseFileName
	rm $ltexLsBinaryPath
	rm -rf $ltexLsAppDirectory
	wget https://github.com/valentjn/ltex-ls/releases/download/$ltexLsVersion/$ltexLsFileNameWithPlatform.tar.gz
	gunzip $ltexLsFileNameWithPlatform.tar.gz
	tar xf $ltexLsFileNameWithPlatform.tar
	mv $ltexLsBaseFileName $dataHome
	sudo ln -s $ltexLsAppDirectory/bin/ltex-ls $ltexLsBinaryPath 

	# Clean up.
	popd
	rm -rf $temporaryDirectory

	echo "Done."
end
