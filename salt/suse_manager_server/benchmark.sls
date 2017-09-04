include:
  - suse_manager_server.initial_content

spacewalk_utils:
  pkg.latest:
    - name: spacewalk-utils
    - require:
      - sls: suse_manager_server.initial_content

create_initial_cloned_channels:
  cmd.run:
    - name: |
        spacewalk-clone-by-date \
          -u admin -p admin \
          --channels=sles12-sp1-pool-x86_64 clone-2015q4-sles12-sp1-pool-x86_64 \
          --channels=sles12-sp1-updates-x86_64 clone-2015q4-sles12-sp1-updates-x86_64 \
          --channels=sle-manager-tools12-pool-x86_64-sp1 clone-2015q4-sle-manager-tools12-pool-x86_64-sp1 \
          --channels=sle-manager-tools12-updates-x86_64-sp1 clone-2015q4-sle-manager-tools12-updates-x86_64-sp1 \
          --to_date=2015-12-31 \
          --assumeyes
    - require:
      - pkg: spacewalk_utils

create_final_cloned_channels:
  cmd.run:
    - name: |
        spacewalk-clone-by-date \
          -u admin -p admin \
          --channels=sles12-sp1-pool-x86_64 clone-2016q1-sles12-sp1-pool-x86_64 \
          --channels=sles12-sp1-updates-x86_64 clone-2016q1-sles12-sp1-updates-x86_64 \
          --channels=sle-manager-tools12-pool-x86_64-sp1 clone-2016q1-sle-manager-tools12-pool-x86_64-sp1 \
          --channels=sle-manager-tools12-updates-x86_64-sp1 clone-2016q1-sle-manager-tools12-updates-x86_64-sp1 \
          --to_date=2016-03-31 \
          --assumeyes
    - require:
      - pkg: spacewalk_utils

create_final_activation_key:
  cmd.run:
    - name: |
        spacecmd -u admin -p admin -- activationkey_create -n final -d final -b clone-2016q1-sles12-sp1-pool-x86_64 &&
        spacecmd -u admin -p admin -- activationkey_addchildchannels 1-final clone-2016q1-sles12-sp1-updates-x86_64 clone-2016q1-sle-manager-tools12-pool-x86_64-sp1 clone-2016q1-sle-manager-tools12-updates-x86_64-sp1
    - unless: spacecmd -u admin -p admin activationkey_list | grep -x 1-final
    - require:
      - cmd: create_final_cloned_channels
