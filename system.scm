;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu)(nongnu packages linux)(gnu services)(gnu packages shells))
(use-service-modules cups desktop networking xorg ssh)

(operating-system
  (kernel linux)
  (firmware (cons* iwlwifi-firmware
		   %base-firmware))
  (locale "en_US.utf8")
  (timezone "America/New_York")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "Yamaho")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
			(name "nixbld1")
			(comment "")
			(group "nixbld")
			(supplementary-groups
				'("nixbld"))
			(create-home-directory? #f)
			(shell "$(which nologin)")
			(system? #t))

		(user-account
                  (name "mitzuri")
                  (comment "Mitzuri")
                  (group "users")
                  (home-directory "/home/mitzuri")
                  (supplementary-groups '("wheel" "netdev" "audio" "video"))
		  (shell (file-append zsh "/bin/zsh"))
									)
                %base-user-accounts))

  (groups (cons* (user-group
	(name "nixbld"))
	%base-groups))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages (append (list
			  (specification->package "icedtea")
			  (specification->package "bluez")
			  (specification->package "qtile")
			  (specification->package "kitty")
			  (specification->package "nix")
			  (specification->package "awesome")
                          (specification->package "nss-certs"))
                    %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append (list

                 ;; To configure OpenSSH, pass an 'openssh-configuration'
                 ;; record as a second argument to 'service' below.
                 (service openssh-service-type)
                 (service tor-service-type)
                 (service cups-service-type)
		 (service bluetooth-service-type)

                 (set-xorg-configuration
                  (xorg-configuration (keyboard-layout keyboard-layout))))
           ;; This is the default list of services we
           ;; are appending to.
		 (modify-services %desktop-services
				  (guix-service-type config => (guix-configuration
								(inherit config)
								(substitute-urls
								 (append (list "https://substitutes.nonguix.org")
									 %default-substitute-urls))
								(authorized-keys
								 (append (list (local-file "signing-key.pub"))
									 %default-authorized-guix-keys)))))
		 ))

  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))
  (swap-devices (list (swap-space
                        (target (uuid
                                 "d0be8d82-84c5-4108-95bf-68c1b84c62b4")))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/")
                         (device (uuid
                                  "0f2f00b8-8507-4830-a9e6-07a8f7abbbf6"
                                  'ext4))
                         (type "ext4"))
                       (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "C4EB-C46F"
                                       'fat32))
                         (type "vfat")) %base-file-systems)))
