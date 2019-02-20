using AppIndicator;
using GLib;
using Gtk;
using Soup;

public class IndicatorExample {
    public static int main(string[] args) {
        Gtk.init(ref args);

        var indicator = new Indicator("Golem Unlimited", "golemu", IndicatorCategory.APPLICATION_STATUS);
        Window window = null;

        try {
            var builder = new Builder();
            //builder.add_from_file("gu-provider-ui-linux.glade");
            builder.add_from_resource("/network/golem/gu-provider-ui-linux/window.glade");
            //builder.connect_signals(null);
            window = builder.get_object("window") as Window;
            //window.show_all();
        } catch (Error e) {
            stderr.printf("Error while loading GUI: %s\n", e.message);
            return 1;
        }

        indicator.set_status(IndicatorStatus.ACTIVE);
        indicator.set_icon("golemu");
        //indicator.set_attention_icon("x");

        var menu = new Gtk.Menu();
        var item = new Gtk.MenuItem.with_label("Snooze");
        var item_auto_mode = new Gtk.CheckMenuItem.with_label("Auto Mode");

        item.activate.connect(() => {
            //indicator.set_status(IndicatorStatus.ATTENTION);
        });
        item.show();
        item_auto_mode.show();
        menu.append(item);
        menu.append(item_auto_mode);

        var item_configure = new Gtk.MenuItem.with_label("Configure");
        item_configure.show();
        item_configure.activate.connect(() => {
            stdout.printf("HELLO\n");
            window.show_all();
        });
        menu.append(item_configure);

        item = new Gtk.MenuItem.with_label("Exit");
        item.show();
        item.activate.connect(() => {
            Gtk.main_quit();
        });
        menu.append(item);

        indicator.set_menu(menu);
        indicator.set_label("Connected", "A");

        var session = new Soup.Session();
        var message = new Soup.Message("GET", "http://localhost:61621/");
        session.send_message(message);
        message.response_headers.foreach ((name, val) => {
            stdout.printf ("Name: %s -> Value: %s\n", name, val);
        });
        stdout.printf("Message length: %lld\n%s\n",
                       message.response_body.length,
                       message.response_body.data);

        Gtk.main();
        return 0;
    }
}
