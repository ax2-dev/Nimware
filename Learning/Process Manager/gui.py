import tkinter as tk
from tkinter import ttk, messagebox
import subprocess

class AutoProcessManager(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("OmMon")

        search_frame = ttk.Frame(self, padding=10)
        search_frame.pack(fill='x')

        ttk.Label(search_frame, text="Target Process:").pack(side='left')
        self.process_entry = ttk.Entry(search_frame, width=25)
        self.process_entry.pack(side='left', padx=5)

        self.search_btn = ttk.Button(
            search_frame, 
            text="Find Processes", 
            command=self.find_processes
        )
        self.search_btn.pack(side='left')

        self.pid_listbox = tk.Listbox(self, selectmode='multiple', height=5)
        self.pid_listbox.pack(fill='x', padx=10, pady=5)

        btn_frame = ttk.Frame(self)
        btn_frame.pack(pady=10)

        self.kill_btn = ttk.Button(
            btn_frame, 
            text="Kill Selected", 
            command=self.kill_selected
        )
        self.kill_btn.pack(side='left', padx=5)

        self.refresh_btn = ttk.Button(
            btn_frame,
            text="Refresh List",
            command=self.find_processes
        )
        self.refresh_btn.pack(side='left')

    def find_processes(self):
        process_name = self.process_entry.get().strip()
        if not process_name:
            messagebox.showerror("Error", "Please enter a process name")
            return

        try:
            result = subprocess.run(
                ["./finder.exe", process_name],
                check=True,
                capture_output=True,
                text=True,
                creationflags=subprocess.CREATE_NO_WINDOW
            )
            pids = result.stdout.strip().split(',')
            if pids and pids != ['']:  
                self.update_pid_list(pids)
            else:  
                self.pid_listbox.delete(0, tk.END)

        except subprocess.CalledProcessError as e:
            error_msg = self.parse_nim_error(e.stderr)
            messagebox.showerror("Search Error", error_msg)
            if "NO_PROCESS" in e.stderr:  
                self.pid_listbox.delete(0, tk.END)

    def update_pid_list(self, pids):
        self.pid_listbox.delete(0, tk.END)
        for pid in pids:
            self.pid_listbox.insert(tk.END, pid)

    def kill_selected(self):
        selected = self.pid_listbox.curselection()
        if not selected:
            messagebox.showwarning("Warning", "No PIDs selected")
            return

        pids = [self.pid_listbox.get(i) for i in selected]
        try:
            subprocess.run(
                ["./killer.exe", ",".join(pids)],
                check=True,
                capture_output=True,
                text=True,
                creationflags=subprocess.CREATE_NO_WINDOW
            )

            for index in reversed(selected):  
                self.pid_listbox.delete(index)
            messagebox.showinfo("Success", f"Terminated {len(pids)} processes")

        except subprocess.CalledProcessError as e:
            error_msg = self.parse_nim_error(e.stderr)
            messagebox.showerror("Termination Error", error_msg)

    def parse_nim_error(self, stderr):
        error_map = {
            "NO_PROCESS": "No running instances found",
            "INVALID_PID": "Invalid PID format detected",
            "OPEN_ERROR": "Failed to open process handle",
            "TERMINATE_ERROR": "Process termination failed"
        }
        for key, message in error_map.items():
            if key in stderr:
                return f"{message}: {stderr.split(':')[-1].strip()}"
        return "Unknown error occurred"

if __name__ == "__main__":
    app = AutoProcessManager()
    app.mainloop()