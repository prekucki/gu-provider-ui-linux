
//using AppIndicator;
using GLib;
using Gtk;

public class IndicatorExample {
	public static int main(string[] args) {
		Gtk.init(ref args);
        Gtk.main();
        return 0;

//	var trayIcon  = new Gtk.StatusIcon.from_file ("/home/prekucki/gu-provider-indicator/data/icons/golemu.png");

//        var indicator = new Indicator("Golem unlimited", "golemu", IndicatorCategory.APPLICATION_STATUS);

/*
        var indicator = new Indicator.with_path("Golem unlimited", "golemu",
                                              IndicatorCategory.APPLICATION_STATUS, "/home/reqc/projects/gu-provider-indicator/build-rel/src");
*/
/*
        indicator.set_status(IndicatorStatus.ACTIVE);
        //indicator.set_icon("golemu");
        indicator.set_attention_icon("golem");

        var menu = new Gtk.Menu();

        var item = new Gtk.MenuItem.with_label("Snooze");
		
        item.activate.connect(() => {
    		indicator.set_status(IndicatorStatus.ATTENTION);
		});
        item.show();
        menu.append(item);
		

        item = new Gtk.MenuItem.with_label("Exit");
        item.show();
        item.activate.connect(() => {    		
			Gtk.main_quit();
		});
        menu.append(item);

        indicator.set_menu(menu);
*/
//	trayIcon.visible=true;
        Gtk.main();
        return 0;
	}
	
}
