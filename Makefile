THEME_NAME := simple-sddm
INSTALL_DIR := /usr/share/sddm/themes/$(THEME_NAME)
THEME_DIR := $(DESTDIR)$(INSTALL_DIR)

install:
	@echo "Installing $(THEME_NAME) to $(THEME_DIR)"
	install -d $(THEME_DIR)
	install -m 644 metadata.desktop $(THEME_DIR)/
	install -m 644 Main.qml $(THEME_DIR)/
	@if [ -f theme.conf ]; then install -m 644 theme.conf $(THEME_DIR)/; fi
	@if [ -f preview.png ]; then install -m 644 preview.png $(THEME_DIR)/; fi
	@echo "Done. Set in /etc/sddm.conf: [Theme] Current=$(THEME_NAME)"

uninstall:
	rm -rf $(THEME_DIR)

GREETER ?= $(shell command -v sddm-greeter-qt6 >/dev/null 2>&1 && echo sddm-greeter-qt6 || echo sddm-greeter)

test:
	@echo "Run preview: $(GREETER) --test-mode --theme ."
	@$(GREETER) --test-mode --theme .

.PHONY: install uninstall test
