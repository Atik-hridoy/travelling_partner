import os
import glob

directory = r"c:\Users\atika\Documents\hridoy\my-project_new_eddition\sports-go\voyenta\lib\features\ai_planning"
files = glob.glob(os.path.join(directory, "**", "*.dart"), recursive=True)

for file in files:
    with open(file, "r") as f:
        content = f.read()

    # Opacity
    content = content.replace("withOpacity(0.15)", "withValues(alpha: 0.15)")
    content = content.replace("withOpacity(0.1)", "withValues(alpha: 0.1)")
    content = content.replace("withOpacity(0.2)", "withValues(alpha: 0.2)")
    content = content.replace("withOpacity(0.3)", "withValues(alpha: 0.3)")
    content = content.replace("withOpacity(0.4)", "withValues(alpha: 0.4)")
    content = content.replace("withOpacity(0.5)", "withValues(alpha: 0.5)")
    content = content.replace("withOpacity(0.7)", "withValues(alpha: 0.7)")
    content = content.replace("withOpacity(0.8)", "withValues(alpha: 0.8)")
    content = content.replace("withOpacity(0.9)", "withValues(alpha: 0.9)")

    # Typography
    content = content.replace("VoyentaTypography.titleMd", "VoyentaTypography.bodyLg")
    content = content.replace("VoyentaTypography.labelSm", "VoyentaTypography.bodyMd")
    content = content.replace("VoyentaTypography.displaySm", "VoyentaTypography.displayLgMobile")

    # Colors
    content = content.replace("VoyentaColors.primaryFixed", "VoyentaColors.primaryContainer")

    # CustomButton null onPressed
    # ai_date_selector.dart
    content = content.replace("onPressed: (selectedStartDate != null && selectedEndDate != null)\n                    ? () {\n                        widget.onSelected(\"Oct $selectedStartDate - Oct $selectedEndDate\");\n                      }\n                    : null,",
                              "onPressed: () {\n                  if (selectedStartDate != null && selectedEndDate != null) {\n                    widget.onSelected(\"Oct $selectedStartDate - Oct $selectedEndDate\");\n                  }\n                },")
    # ai_style_selector.dart
    content = content.replace("onPressed: _selectedStyles.isNotEmpty\n              ? () {\n                  widget.onSelected(\"Interests: ${_selectedStyles.join(', ')}\");\n                }\n              : null,",
                              "onPressed: () {\n          if (_selectedStyles.isNotEmpty) {\n            widget.onSelected(\"Interests: ${_selectedStyles.join(', ')}\");\n          }\n        },")

    with open(file, "w") as f:
        f.write(content)
