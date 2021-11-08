# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  console = {
    keyMap = "fr";
    #font = "ter-d28b";
  };
  #i18n = { defaultLocale = "en_US.UTF-8"; };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    #plasma5.enable = true;
    displayManager = {
      autoLogin.enable = true;
      autoLogin.user = "sacha";
      defaultSession = "none+i3";
      sddm = {
        enable = true;
        autoNumlock = true;
        settings = {
          Autologin = {
            User = "sacha";
            Session = "none+i3";
          };
        };
      };
    };
    desktopManager = {
      xterm.enable = false;
      plasma5 = { enable = true; };
      #xfce = {
      #  enable = true;
      #  noDesktop = true;
      #  enableXfwm = false;
      #};
    };
    videoDrivers = [ "nvidia" ];
    autoRepeatDelay = 200;
    autoRepeatInterval = 40;
    libinput = {
      enable = true;
      mouse = { accelProfile = "flat"; };
    };

    windowManager.i3.package = pkgs.i3-gaps;
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [ rofi dmenu i3lock i3status ];
    };
  };
  programs = {
    dconf = { enable = true; };

  };
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.cpu.amd.updateMicrocode = true;

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [ liberation_ttf roboto fira-code ];
    fontDir.enable = true;

    fontconfig = {
      defaultFonts = {
        serif = [ "Liberation" ];
        sansSerif = [ "Roboto" ];
        monospace = [ "Fira Code" ];
      };
    };
  };

  # Enable the Plasma 5 Desktop Environment.
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "fr";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  #sound.enable = true;
  #hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sacha = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  security = {
    rtkit.enable = true;
    sudo.extraRules = [{
      users = [ "sacha" ];
      commands = [{
        command = "ALL";
        options = [ "NOPASSWD" ];
      }];
    }];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    firefox
    lxappearance
    nitrogen
    micro
    psmisc
    alacritty
    stow
    git
    fzf
    neofetch
    pavucontrol
    starship
    vscode
    papirus-icon-theme
    arc-theme
    nixfmt
    pcmanfm
    xclip
    xsel
    bat
    mako
    dunst
    terminus_font
  ];

  environment.pathsToLink = [ "/libexec" ];
  environment.variables = {
    TERMINAL = "alacritty";
    EDITOR = "nvim";
    VISUAL = "code";
  };

  programs = {
    neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
      defaultEditor = true;
    };
    fish = {
      enable = true;
      shellInit = ''
        set fish_greeting
        starship init fish | source
      '';
    };

  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services = {
    fstrim.enable = true;
    openssh.enable = true;
    picom = {
      enable = true;
      shadow = true;
      fade = true;
      fadeDelta = 2;
      backend = "glx";
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };
    printing.enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

