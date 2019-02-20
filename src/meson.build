cfg_gu_provider_ui_linux = configuration_data()
cfg_gu_provider_ui_linux.set('DATADIR', join_paths(get_option('prefix'),get_option('datadir')))
cfg_gu_provider_ui_linux.set('PKGDATADIR', join_paths(get_option('prefix'),get_option('datadir'),'gu-provider-ui-linux'))
cfg_gu_provider_ui_linux.set('GETTEXT_PACKAGE', 'gu-provider-ui-linux')
cfg_gu_provider_ui_linux.set('RELEASE_NAME', 'gu-provider-ui-linux')
cfg_gu_provider_ui_linux.set('PREFIX', get_option('prefix'))
cfg_gu_provider_ui_linux.set('VERSION', '1.0.0')
cfg_gu_provider_ui_linux.set('TESTSRCDIR', meson.source_root())

cfgfile_1 = configure_file(input: 'Config.vala.base',output: 'Config.vala',configuration: cfg_gu_provider_ui_linux)

gu_provider_ui_linux_deps = [appindicator_0_1_dep, atk_dep, cairo_dep, gdk_3_0_dep, gdk_pixbuf_2_0_dep, gio_2_0_dep, glib_2_0_dep, gobject_2_0_dep, gtk_3_0_dep, pango_dep, soup_dep, x11_dep]
gu_provider_ui_linux_sources = [cfgfile_1, 'gu-provider-ui-linux.vala']
gu_provider_ui_linux_link_args = ['-rdynamic']

executable('gu-provider-ui-linux',
           gu_provider_ui_linux_sources,
           resources,
           dependencies: gu_provider_ui_linux_deps,
           vala_args: ['--gresources=../data/resources.xml'],
           link_args: gu_provider_ui_linux_link_args,
           install: true)
