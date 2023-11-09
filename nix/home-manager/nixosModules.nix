{ inputs, cell }: {
  mkNixOSModule = imports: { username, unstable, ... }: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {
        inherit inputs username unstable;
      };

      users.${username} = {
        inherit imports;
      };
    };
  };
}
