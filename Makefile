THEME_NAME := simple-sddm
INSTALL_DIR := /usr/share/sddm/themes/$(THEME_NAME)
THEME_DIR := $(DESTDIR)$(INSTALL_DIR)
SYSCONFDIR ?= /etc
CONF_D := $(DESTDIR)$(SYSCONFDIR)/sddm.conf.d
CONF_FILE := $(CONF_D)/10-$(THEME_NAME).conf

install:
	@echo "Installing $(THEME_NAME) to $(THEME_DIR)"
	install -d $(THEME_DIR)
	install -m 644 metadata.desktop $(THEME_DIR)/
	install -m 644 Main.qml $(THEME_DIR)/
	@if [ -f theme.conf ]; then install -m 644 theme.conf $(THEME_DIR)/; fi
	@if [ -f preview.png ]; then install -m 644 preview.png $(THEME_DIR)/; fi
	install -d -m 755 $(CONF_D)
	printf "[Theme]\nCurrent=$(THEME_NAME)\n" > $(CONF_FILE).tmp
	install -m 644 $(CONF_FILE).tmp $(CONF_FILE)
	rm -f $(CONF_FILE).tmp
	@echo "Wrote $(CONF_FILE)"
	@if [ -z "$(DESTDIR)" ] && grep -Eq '^\s*Current\s*=' $(SYSCONFDIR)/sddm.conf 2>/dev/null; then \
		echo "WARNING: $(SYSCONFDIR)/sddm.conf contains Current= (overrides sddm.conf.d). Please comment it out."; \
	fi

uninstall:
	rm -rf $(THEME_DIR)
	rm -f $(DESTDIR)$(SYSCONFDIR)/sddm.conf.d/10-$(THEME_NAME).conf
	rmdir --ignore-fail-on-non-empty $(DESTDIR)$(SYSCONFDIR)/sddm.conf.d 2>/dev/null || true

GREETER ?= $(shell command -v sddm-greeter-qt6 >/dev/null 2>&1 && echo sddm-greeter-qt6 || echo sddm-greeter)

test:
	@echo "Run preview: $(GREETER) --test-mode --theme ."
	@$(GREETER) --test-mode --theme .

.PHONY: install uninstall test
