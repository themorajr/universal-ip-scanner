import subprocess
from tqdm import tqdm
import time
from colorama import Fore, Style, init

# Initialize colorama
init(autoreset=True)

def ping_ip(ip):
    try:
        # Use subprocess to run the ping command
        output = subprocess.run(['ping', '-n', '1', '-w', '1000', ip], capture_output=True, text=True, timeout=2)
        
        if "Reply from" in output.stdout and "Destination host unreachable" not in output.stdout:
            return "Alive"
        elif "Destination host unreachable" in output.stdout:
            return "Unreachable"
        else:
            return "Dead"
    except subprocess.TimeoutExpired:
        return "Timeout"
    except Exception:
        return "Error"

def check_ips_from_file(filename):
    with open(filename, 'r') as file:
        ips = [line.strip() for line in file.readlines()]

    results = []
    
    # Create a progress bar
    with tqdm(total=len(ips), desc="Pinging IPs", bar_format="{l_bar}{bar}| {n_fmt}/{total_fmt}") as pbar:
        for ip in ips:
            status = ping_ip(ip)
            results.append((ip, status))
            pbar.update(1)
            time.sleep(0.1)  # Add a small delay to make the progress bar visible

    return results

def display_results(results):
    print("\nPing Results:")
    print("-------------")
    for ip, status in results:
        if status == "Alive":
            color = Fore.GREEN
        elif status == "Unreachable":
            color = Fore.YELLOW
        else:
            color = Fore.RED
        print(f"{ip:<15} {color}{status}{Style.RESET_ALL}")

if __name__ == "__main__":
    input_file = "ip.txt"
    results = check_ips_from_file(input_file)
    display_results(results)