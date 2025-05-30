function rl --wraps='sudo nixos-rebuild switch --flake $HOME/.nixdots#torelli-laptop' --description 'alias rl sudo nixos-rebuild switch --flake $HOME/.nixdots#torelli-laptop'
    sudo nixos-rebuild switch --flake $HOME/.nixdots#torelli-laptop
end
