from Bio import SeqIO
import sys

def get_top_n_longest_sequences(input_fasta, output_fasta, n):
    sequences = list(SeqIO.parse(input_fasta, "fasta"))
    
    # Sort sequences by length, longest first
    sorted_sequences = sorted(sequences, key=lambda x: len(x.seq), reverse=True)
    
    # Take the top N sequences
    top_n = sorted_sequences[:n]
    
    # Write the top N sequences to a new FASTA file
    with open(output_fasta, "w") as output_handle:
        SeqIO.write(top_n, output_handle, "fasta")

def print_usage():
    print("Usage:")
    print("  python script.py input.fasta output.fasta N")
    print("  python script.py -h | --help")
    print("\nParameters:")
    print("  input.fasta  - Input FASTA file")
    print("  output.fasta - Output FASTA file with top N sequences")
    print("  N            - Number of top sequences to extract (must be a positive integer)")

if __name__ == "__main__":
    if len(sys.argv) == 2 and (sys.argv[1] == "-h" or sys.argv[1] == "--help"):
        print_usage()
        sys.exit(0)
    
    if len(sys.argv) != 4:
        print("Error: Incorrect number of arguments.")
        print_usage()
        sys.exit(1)
    
    input_fasta = sys.argv[1]
    output_fasta = sys.argv[2]
    try:
        n = int(sys.argv[3])
        if n <= 0:
            raise ValueError("N must be a positive integer.")
    except ValueError:
        print("Error: N must be a positive integer.")
        print_usage()
        sys.exit(1)
    
    get_top_n_longest_sequences(input_fasta, output_fasta, n)