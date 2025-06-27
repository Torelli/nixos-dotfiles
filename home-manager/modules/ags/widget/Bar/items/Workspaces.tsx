import { Gtk } from "astal/gtk4";
import AstalHyprland from "gi://AstalHyprland";
import { range } from "../../../lib/utils";
import { bind } from "astal";
import { Variable } from "astal";
import { ButtonProps } from "astal/gtk4/widget";
import BarItem from "../BarItem";

type WsButtonProps = ButtonProps & {
	ws: AstalHyprland.Workspace;
};

type WorkspacePanelButtonProps = {
	hprMonitor: AstalHyprland.Monitor;
}

function WorkspaceButton({ ws, ...props }: WsButtonProps) {
	const hyprland = AstalHyprland.get_default();
	const classNames = Variable.derive(
		[bind(hyprland, "focusedWorkspace"), bind(hyprland, "clients")],
		(fws, _) => {
			const classes = ["workspace-button"];

			const active = fws.id == ws.id;
			active && classes.push("active");

			const occupied = hyprland.get_workspace(ws.id)?.get_clients().length > 0;
			occupied && classes.push("occupied");
			return classes;
		},
	);

	return (
		<button
			cssClasses={classNames()}
			onDestroy={() => classNames.drop()}
			valign={Gtk.Align.CENTER}
			halign={Gtk.Align.CENTER}
			onClicked={() => ws.focus()}
			{...props}
		/>
	);
}

export default function WorkspacesPanelButton({ hprMonitor }: WorkspacePanelButtonProps) {
	const monitors = AstalHyprland.get_default().get_monitors();
	if (monitors.length === 1) {

		return (
			<BarItem cssClasses={["workspace-button-bg"]}>
				<box cssClasses={["workspace-container"]} spacing={4}>
					{range(6).map((i) => (
						<WorkspaceButton ws={AstalHyprland.Workspace.dummy(i + 1, null)} />
					))}
				</box>
			</BarItem>
		);
	}
	if (hprMonitor.get_name() === 'DP-1') {
		return (
			<BarItem cssClasses={["workspace-button-bg"]}>
				<box cssClasses={["workspace-container"]} spacing={4}>
					<WorkspaceButton ws={AstalHyprland.Workspace.dummy(1, hprMonitor)} />
					<WorkspaceButton ws={AstalHyprland.Workspace.dummy(2, hprMonitor)} />
					<WorkspaceButton ws={AstalHyprland.Workspace.dummy(3, hprMonitor)} />
					<WorkspaceButton ws={AstalHyprland.Workspace.dummy(4, hprMonitor)} />
					<WorkspaceButton ws={AstalHyprland.Workspace.dummy(5, hprMonitor)} />
				</box>
			</BarItem>
		);
	}
	if (hprMonitor.get_name() === 'HDMI-A-1') {
		return (
			<BarItem cssClasses={["workspace-button-bg"]}>
				<box cssClasses={["workspace-container"]} spacing={4}>
					<WorkspaceButton ws={AstalHyprland.Workspace.dummy(6, hprMonitor)} />
					<WorkspaceButton ws={AstalHyprland.Workspace.dummy(7, hprMonitor)} />
					<WorkspaceButton ws={AstalHyprland.Workspace.dummy(8, hprMonitor)} />
					<WorkspaceButton ws={AstalHyprland.Workspace.dummy(9, hprMonitor)} />
					<WorkspaceButton ws={AstalHyprland.Workspace.dummy(10, hprMonitor)} />
				</box>
			</BarItem>
		);
	}


}
