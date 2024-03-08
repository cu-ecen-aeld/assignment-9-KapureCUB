##############################################################
#
# LDD
#
##############################################################

#module variables
SCULL_MODULE = scull
MISC_MODULE = misc-modules
HELLO_MODULE = hello
FAULTY_MODULE = faulty

LDD_VERSION = cbd43ee59b9bc20408f5c7a1e82d90cdec8db16c 
LDD_SITE = git@github.com:cu-ecen-aeld/assignment-7-KapureCUB.git
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES
LDD_MODULE_SUBDIRS = $(MISC_MODULE)
LDD_MODULE_SUBDIRS += $(SCULL_MODULE)

#path variables 
AESD_MODULES_DIR = /lib/modules/aesd-modules

define LDD_INSTALL_TARGET_CMDS
        #install .ko, load and unload scripts to AESD_MODULES_DIR
        $(INSTALL) -d 0755 $(TARGET_DIR)$(AESD_MODULES_DIR)
	
	#misc_modules
	$(INSTALL) -d 0755 $(TARGET_DIR)$(AESD_MODULES_DIR)/$(MISC_MODULE)
        $(INSTALL) -m 0755 $(@D)/$(MISC_MODULE)/$(FAULTY_MODULE).ko $(TARGET_DIR)$(AESD_MODULES_DIR)/$(MISC_MODULE)
	$(INSTALL) -m 0755 $(@D)/$(MISC_MODULE)/$(HELLO_MODULE).ko $(TARGET_DIR)$(AESD_MODULES_DIR)/$(MISC_MODULE)
	$(INSTALL) -m 0755 $(@D)/$(MISC_MODULE)/module_load $(TARGET_DIR)$(AESD_MODULES_DIR)/$(MISC_MODULE)
	$(INSTALL) -m 0755 $(@D)/$(MISC_MODULE)/module_unload $(TARGET_DIR)$(AESD_MODULES_DIR)/$(MISC_MODULE)

        #scull
        $(INSTALL) -d 0755 $(TARGET_DIR)$(AESD_MODULES_DIR)/$(SCULL_MODULE)
        $(INSTALL) -m 0755 $(@D)/$(SCULL_MODULE)/*.ko $(TARGET_DIR)$(AESD_MODULES_DIR)/$(SCULL_MODULE)
        $(INSTALL) -m 0755 $(@D)/$(SCULL_MODULE)/scull_load $(TARGET_DIR)$(AESD_MODULES_DIR)/$(SCULL_MODULE)
        $(INSTALL) -m 0755 $(@D)/$(SCULL_MODULE)/scull_unload $(TARGET_DIR)$(AESD_MODULES_DIR)/$(SCULL_MODULE)
	
endef
$(eval $(kernel-module))
$(eval $(generic-package))
