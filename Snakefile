rule mkbed:
    input:"CTCF_NormalizedIntensity_G1E_G1EEr4.txt"
    output:"CTCF_NormalizedIntensity_G1E_JC4.bed"
    shell:"tail -n +2 {input} | cut -f 1,2,3 | SORT -k1,1 -k2,2n > {output}"
rule mkepdbed:
	input:"mouse_epdnew_W0EyU.bed"
	output:"mouse_epdnew.bed"
	shell:"""tail -n +2 {input} | cut -f 1,2,4 | awk 'BEGIN{{FS=" "}} {{print $1 "\t" $2-50 "\t" $2+50 "\t" $3}}' | SORT -k1,1 -k2,2n > {output}"""

#"tail -n +2 {input} | cut -f 1,2,3,4 | SORT -k1,1 -k2,2n > {output}"
rule intersector:
	input:ctcf="CTCF_NormalizedIntensity_G1E_JC4.bed",
	      epd="mouse_epdnew.bed"
	output:"epd_CTCFchip_intersect.bed"
	shell:"bedtools intersect -wa -wb -a {input.ctcf} -b {input.epd} > {output}"