#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>
#include <dwmapi.h> 
#include <vector>

#include "flutter_window.h"
#include "utils.h"
#include <bitsdojo_window_windows/bitsdojo_window_plugin.h>
auto bdw = bitsdojo_window_configure(BDW_CUSTOM_FRAME | BDW_HIDE_ON_STARTUP);

#pragma comment(lib, "dwmapi.lib")

int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
                      _In_ wchar_t *command_line, _In_ int show_command) {
  
  if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
    CreateAndAttachConsole();
  }

  ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

  flutter::DartProject project(L"data");
  std::vector<std::string> command_line_arguments = GetCommandLineArguments();
  project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

  FlutterWindow window(project);
  Win32Window::Point origin(10, 10);
  Win32Window::Size size(750, 700);

  if (!window.Create(L"ArchitectConsole", origin, size)) {
    return EXIT_FAILURE;
  }

  // Get the Window Handle (ID)
  HWND hwnd = window.GetHandle();

  
  // Set the Window Title Bar Color (Windows 11 Only)
  COLORREF captionColor =  RGB(13,13,13); 
  COLORREF textColor = RGB(255, 255, 255); // White Text

  // DWMWA_CAPTION_COLOR = 35, DWMWA_TEXT_COLOR = 36
  DwmSetWindowAttribute(hwnd, 35, &captionColor, sizeof(captionColor));
  DwmSetWindowAttribute(hwnd, 36, &textColor, sizeof(textColor));

  // --- 2. Disable Resize & Maximize ---
  long style = GetWindowLong(hwnd, GWL_STYLE);
  style &= ~WS_MAXIMIZEBOX; // Maximize button khatam
  style &= ~WS_THICKFRAME;  // Resize handle khatam
  SetWindowLong(hwnd, GWL_STYLE, style);

  // Window ko refresh karein taaki styles apply ho jayein
  SetWindowPos(hwnd, NULL, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE | SWP_NOZORDER | SWP_FRAMECHANGED);

  window.SetQuitOnClose(true);

  ::MSG msg;
  while (::GetMessage(&msg, nullptr, 0, 0)) {
    ::TranslateMessage(&msg);
    ::DispatchMessage(&msg);
  }

  ::CoUninitialize();
  return EXIT_SUCCESS;
}