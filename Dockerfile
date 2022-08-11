FROM nixos/nix:2.10.3
RUN nix-channel --update
RUN echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf

# RUN nix-env -i home-manager
