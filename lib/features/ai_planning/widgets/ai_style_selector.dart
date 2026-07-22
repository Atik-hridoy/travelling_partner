import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/custom_button.dart';

class AiStyleSelector extends StatefulWidget {
  final Function(String) onSelected;

  const AiStyleSelector({super.key, required this.onSelected});

  @override
  State<AiStyleSelector> createState() => _AiStyleSelectorState();
}

class _AiStyleSelectorState extends State<AiStyleSelector> {
  final Set<String> _selectedStyles = {};
  final Set<String> _selectedInterests = {};

  final List<Map<String, dynamic>> interests = [
    {'label': 'Museums', 'icon': Icons.museum},
    {'label': 'Temples', 'icon': Icons.account_balance},
    {'label': 'Hidden Gems', 'icon': Icons.search},
    {'label': 'Photography', 'icon': Icons.camera_alt},
    {'label': 'Hiking', 'icon': Icons.hiking},
    {'label': 'Local Markets', 'icon': Icons.shopping_bag},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Asymmetric Bento Grid
        Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildStyleCard(
                'Adventure',
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBCH2M287Za3t_Wh5RzCw1i9PK7zWuVnt0euWhQd_YnOMkSssI75Co05Vly30tsObqpJ8qxW4ky827bG_dOVA5AR9RWJ6srHXWaq5NlBpi29gzneuGjG-RbhDwadXPmeftYQ7xeSwvzNzlaBDmCPVgSn4R5mw10XqqFj4fMto8tfUnekAybMHie_N-nYqebAmiENNimmzL-IFUqIaQuJAXUcFDNnoQNq--E6bqfIj_jR79ZhIgfjI44wStDr7viZjsF1JtnVRz7BIIv',
                height: 160,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: _buildStyleCard(
                'Luxury',
                'https://lh3.googleusercontent.com/aida-public/AB6AXuDEQSTR_ZT8zdFKYJ3HXGzc7LjcNGX5r6ysQpP4r-mtN-701ThuqvjKhiyg2ZQt2n8HI_JW4af5zaE5I6V_cfeJM5CK1YHc9a7OK4I3pn0RZnI1oPybeC_CZIOKck8IVQiQn6NlG9q4Ij-LMwe8he8T5uVrhdXBkCiRUY4-Atq73o_AK62AMVas6q7VB4isUfJovq-_f_xClO0dUgEkCAew_KUs_jLL-E8kuB4j-ex4qK2yj9mGZfwDxStCzuZFrEr-Z4JcAEtd6bfb',
                height: 160,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStyleCard(
                'Food',
                'https://lh3.googleusercontent.com/aida-public/AB6AXuAiM85dN0jbcCpSPy8ToHfh0m79B9j-4JECU07kEkZLyp5dHcx8fMpae7l8U_stTMeaG2y0A3B4OGQBpTXF1XAowNvq1A83tl-4-kFI_aHlZ9deHYy6MtlhPg-CXCivguYREZxIu3NJMoBtwXl4f2jLoOdFdZ04O1HqviaO4KwPipOIWKk_BYvaCNEcuBkoXNxWRBpAIBknirqeSCyxsbg7IP9BoSXopbqnvq2ihObIZLclRIvDiZMDTyoAHpgTAY82MsNETJzvLEbX',
                height: 120,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStyleCard(
                'Nature',
                'https://lh3.googleusercontent.com/aida-public/AB6AXuDVWTPn4MHHwwTj9MhCywzZ1Nhq_ezDTs6zS6-SuosY72oGlNCWOb6eHLoptFkfxVxRwuKHpehrnPvXt-G6MZOQsCpIeFNlD7MzqmRWwfXJslbBFq9SiRmCSuKjfGYhMzRH_HY2JdsKlY0KsqOdEUC903BP7oIgD_hqUXtaCimt8DiXKS_lw2GOCOL_dzKXKg-UUp2OTrkAEUel9NDfPS6DLEwIPiz7OWJ_2BDkL26xKfEg5cIbGogPt-LmGbroT3OAsh3RK3gDDe8h',
                height: 120,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStyleCard(
                'Culture',
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBLjBBAClqlhY6n0ZxNITZl916eC7ShM5mm2Pnxw5DDLyT13wZhoKjUtLfpj6ygUtWMD0d-3sUZoTBuLHpJEAgEh-4IElmWJUUVWwxdhs7LuLcvPgXduYCv383ZF763T5KUFLisTffrBwmzV6KYwWiTZwBcQLjkUipF-DRRhVRzNxdIELmgGeUFSqk3ZhJxCKLY3Ucn29iPdPXlZ4X8m40Bfq1846HGzDoJxV4r9u_40T55nGKgCzyYmUDNgkMrJQHmRtrIqygm6pEX',
                height: 120,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Smart Interests Section
        Text('Smart Interests', style: VoyentaTypography.titleMd.copyWith(color: VoyentaColors.primary, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: interests.map((interest) {
            final isSelected = _selectedInterests.contains(interest['label']);
            return ActionChip(
              avatar: Icon(
                interest['icon'] as IconData,
                color: isSelected ? Colors.white : VoyentaColors.onSurfaceVariant,
                size: 16,
              ),
              label: Text(interest['label'] as String),
              labelStyle: VoyentaTypography.labelSm.copyWith(
                color: isSelected ? Colors.white : VoyentaColors.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              backgroundColor: isSelected ? VoyentaColors.primary : Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: isSelected ? VoyentaColors.primary : VoyentaColors.outlineVariant.withValues(alpha: 0.5)),
              ),
              onPressed: () {
                setState(() {
                  if (isSelected) {
                    _selectedInterests.remove(interest['label']);
                  } else {
                    _selectedInterests.add(interest['label'] as String);
                  }
                });
              },
            );
          }).toList(),
        ),
        
        const SizedBox(height: 32),
        CustomButton(
          text: 'Build My Trip',
          onPressed: () {
            if (_selectedStyles.isNotEmpty || _selectedInterests.isNotEmpty) {
              final allInterests = [..._selectedStyles, ..._selectedInterests];
              widget.onSelected("Interests: ${allInterests.join(', ')}");
            }
          },
        ),
      ],
    );
  }

  Widget _buildStyleCard(String title, String imageUrl, {required double height}) {
    final isSelected = _selectedStyles.contains(title);
    
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedStyles.remove(title);
          } else {
            _selectedStyles.add(title);
          }
        });
      },
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? VoyentaColors.primary : Colors.transparent,
            width: isSelected ? 4 : 0,
          ),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: VoyentaColors.primary.withValues(alpha: 0.3),
                blurRadius: 10,
              ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withValues(alpha: 0.8),
                Colors.transparent,
              ],
            ),
          ),
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                style: VoyentaTypography.titleMd.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isSelected)
                const Icon(Icons.check_circle, color: VoyentaColors.primaryFixed, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
