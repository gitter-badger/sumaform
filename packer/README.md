# How to rebuild Packer images

 - Download and install [Packer](https://www.packer.io/downloads.html)
 - Run
 ```
 packer build <IMAGE_NAME>.json
 ```
 - in case of errors, run again with full logging:
 ```
 PACKER_LOG=1 packer build <IMAGE_NAME>.json
 ```

# Credits

These Packer scripts were originally derived from [Christoph Hartmann's packer-rhel project](https://github.com/TelekomLabs/packer-rhel).
