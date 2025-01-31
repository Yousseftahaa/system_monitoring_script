#!/bin/bash


OUTPUT_FILE="report.log"

THRESHOLD=80

echo " System Report " > "$OUTPUT_FILE"
echo "started on: $(date)" >> "$OUTPUT_FILE"


echo -e " Disk Usage " >> "$OUTPUT_FILE"
df -h | awk -v threshold=$THRESHOLD '
NR==1 {print $0} 
NR>1 {
    use=$5+0  # 3shan akhly elpercent number bas 
    if (use > threshold) {
        print $0 " [WARNING: Usage exceeds " threshold "%]"
    } else {
        print $0
    }
}' >> "$OUTPUT_FILE"


echo -e " CPU Usage " >> "$OUTPUT_FILE"
top -bn1 | grep "Cpu(s)" >> "$OUTPUT_FILE"


echo -e " Memory Usage " >> "$OUTPUT_FILE"
free -h >> "$OUTPUT_FILE"


echo -e " Top 5 Memory-Consuming Processes " >> "$OUTPUT_FILE"
ps aux --sort=-%mem | head -n 6 >> "$OUTPUT_FILE"


cat "$OUTPUT_FILE"


echo -e "\nReport saved to $OUTPUT_FILE"
