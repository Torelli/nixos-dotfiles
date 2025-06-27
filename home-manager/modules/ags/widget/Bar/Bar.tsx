import { App, Astal, Gtk, Gdk } from "astal/gtk4";
import TimePanelButton from "./items/Clock";
import WorkspacesPanelButton from "./items/Workspaces";
import NetworkSpeedPanelButton from "./items/NetWorkSpeed";
import RecordIndicatorPanelButton from "./items/RecordIndicator";
import LauncherPanelButton from "./items/AppLauncher";
import NotifPanelButton from "./items/Notifications";
import QSPanelButton from "./items/SystemIndicators";
import KeyboardLayout from "./items/KeyboardLayout";
import ActiveApp from "./items/ActiveApp";
import Battery from "./items/Battery";
import { separatorBetween } from "../../lib/utils";
import options from "../../option";
import { idle } from "astal";
import { WindowProps } from "astal/gtk4/widget";
import TrayPanelButton from "./items/Tray";
import PowermenuButton from "./items/Powermenu";
import AstalHyprland from "gi://AstalHyprland";
import NotifiCount from "./items/NotifiCount";

const { bar } = options;
const { start, center, end } = bar;

const panelButton = {
  launcher: () => <LauncherPanelButton />,
  workspace: (hprMonitor: AstalHyprland.Monitor) => <WorkspacesPanelButton hprMonitor={hprMonitor} />,
  activeapp: () => <ActiveApp />,
  time: () => <TimePanelButton />,
  // notification: () => <NotifPanelButton />,
  // network_speed: () => <NetworkSpeedPanelButton />,
  keylayout: () => <KeyboardLayout />,
  tray: () => <TrayPanelButton />,
  quicksetting: () => <QSPanelButton />,
  battery: () => <Battery />,
  powermenu: () => <PowermenuButton />,
  recordbutton: () => <RecordIndicatorPanelButton />,
  // notifycount: () => <NotifiCount />,
};

type StartProps = {
  hprMonitor: AstalHyprland.Monitor;
};

function Start({ hprMonitor }: StartProps) {
  return (
    <box halign={Gtk.Align.START}>
      {start((s) => [
        ...separatorBetween(
          s.map((s) =>
            s === 'workspace'
              ? panelButton[s](hprMonitor)
              : panelButton[s]()

          ),
          Gtk.Orientation.VERTICAL,
        ),
      ])}
    </box>
  );
}

function Center() {
  return (
    <box>
      {center((c) =>
        separatorBetween(
          c.map((w) => panelButton[w]()),
          Gtk.Orientation.VERTICAL,
        ),
      )}
    </box>
  );
}

function End() {
  return (
    <box halign={Gtk.Align.END}>
      {end((e) =>
        separatorBetween(
          e.map((w) => panelButton[w]()),
          Gtk.Orientation.VERTICAL,
        ),
      )}
    </box>
  );
}

type BarProps = WindowProps & {
  gdkmonitor: Gdk.Monitor;
  hyprlandMonitor: AstalHyprland.Monitor;
};
function Bar({ gdkmonitor, hyprlandMonitor, ...props }: BarProps) {
  const { TOP, LEFT, RIGHT, BOTTOM } = Astal.WindowAnchor;
  const anc = bar.position.get() == "top" ? TOP : BOTTOM;

  return (
    <window
      visible
      layer={Astal.Layer.BOTTOM}
      setup={(self) => {
        // problem when change bar size via margin/padding live
        // https://github.com/wmww/gtk4-layer-shell/issues/60
        self.set_default_size(1, 1);
      }}
      name={"bar"}
      namespace={"bar"}
      gdkmonitor={gdkmonitor}
      anchor={anc | LEFT | RIGHT}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      application={App}
      {...props}
    >
      <centerbox cssClasses={["bar-container"]}>
        <Start hprMonitor={hyprlandMonitor} />
        <Center />
        <End />
      </centerbox>
    </window>
  );
}

export default function(gdkmonitor: Gdk.Monitor) {
  const hyprlandMonitor = AstalHyprland.get_default().get_monitor_by_name(gdkmonitor.get_connector());

  <Bar gdkmonitor={gdkmonitor} hyprlandMonitor={hyprlandMonitor} />;

  bar.position.subscribe(() => {
    App.toggle_window("bar");
    const barWindow = App.get_window("bar")!;
    barWindow.set_child(null);
    App.remove_window(App.get_window("bar")!);
    idle(() => {
      <Bar gdkmonitor={gdkmonitor} hyprlandMonitor={hyprlandMonitor} />;
    });
  });
}
