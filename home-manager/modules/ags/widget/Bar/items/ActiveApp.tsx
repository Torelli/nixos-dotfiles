import Hyprland from "gi://AstalHyprland";
import { Gtk, Gdk } from "astal/gtk4";
import { bind, Binding } from "astal";
import PanelButton from "../PanelButton";
import Pango from "gi://Pango?version=1.0";

function lookUpIcon(iconName: string | null | undefined): string {
  if (!iconName) {
    return "application-x-executable";
  }

  if (iconName === "zen") {
    return "zen-browser"
  }

  const display = Gdk.Display.get_default();
  if (!display) {
    console.error("No display found");
    return "application-x-executable";
  }
  const iconTheme = Gtk.IconTheme.get_for_display(display);
  const possibleNames = [
    iconName.toLowerCase(),
    iconName.toLowerCase().replace(/\s/g, '-'),
    iconName.toLowerCase().replace(/\s/g, ''),
  ];
  for (const name of possibleNames) {
    if (iconTheme.has_icon(name)) {
      return name;
    }
    const variants = [
      `com.${name}`,
      `org.${name}`,
      `${name}.desktop`,
      `application-x-${name}`,
    ];
    for (const variant of variants) {
      if (iconTheme.has_icon(variant)) {
        return variant;
      }
    }
  }
  return "application-x-executable";
}

// 图标组件
const AppIcon = ({
  iconName,
  size = 16
}: {
  iconName: Binding<string | null | undefined>,
  size?: number
}) => {
  return (
    <image
      iconName={iconName.as(name => lookUpIcon(name))}
      pixelSize={size}
    />
  );
};

export default () => {
  const hypr = Hyprland.get_default();
  const focused = bind(hypr, "focusedClient");
  return (
    <revealer
      transitionType={Gtk.RevealerTransitionType.CROSSFADE}
      transitionDuration={300}
      revealChild={focused.as(Boolean)}
    >
      <PanelButton>
        <box spacing={8}>
          {focused.as(client => {
            if (!client) return null;
            // 提取 client 的绑定
            const clientClassBinding = bind(client, "class");
            const clientTitleBinding = bind(client, "title");
            return (
              <>
                <AppIcon
                  iconName={clientClassBinding}
                  size={16}
                />
                <label
                  label={clientTitleBinding.as(value => value ? String(value) : "")}
                  ellipsize={Pango.EllipsizeMode.END}
                  maxWidthChars={15}
                />
              </>
            );
          })}
        </box>
      </PanelButton>
    </revealer>
  );
};
