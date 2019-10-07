task Seqware_Delly {
    File reference_gc
    File tumorBam
    File normalBam
    File reference_gz
    File output_dir = '.'
    command {
        bash /start.sh
        perl /usr/bin/run_seqware_workflow.pl \
        --tumor-bam ${tumorBam} \
        --normal-bam ${normalBam} \
        --refrence-gz ${reference_gz} \
        --reference-gc ${reference_gc}

    }

    output {
        Array[File] somatic_sv_vcf = glob('${output_dir}*.somatic.sv.vcf.gz')
        Array[File] germline_sv_vcf = glob('${output_dir}*.germline.sv.vcf.gz')
        Array[File] sv_vcf = glob('${output_dir}*[0-9].sv.vcf.gz')
        Array[File] somatic_bedpe = glob('${output_dir}*.somatic.sv.bedpe.txt')
        Array[File] somatic_bedpe_tar_gz = glob('${output_dir}*.somatic.sv.bedpe.txt.tar.gz')
        Array[File] germline_bedpe = glob('${output_dir}*.germline.sv.bedpe.txt')
        Array[File] germline_bedpe_tar_gz = glob('${output_dir}*.germline.sv.bedpe.txt.tar.gz')
        Array[File] somatic_sv_readname = glob('${output_dir}.somatic.sv.readname.txt.tar.gz')
        Array[File] germline_sv_readname = glob('${output_dir}*.germline.sv.readname.txt.tar.gz')
        Array[File] cov = glob('${output_dir}*.sv.cov.tar.gz')
        Array[File] cov_plots = glob('${output_dir}*.sv.cov.plots.tar.gz')
        Array[File] sv_log = glob('${output_dir}*.sv.log.tar.gz')
        Array[File] sv_qc = glob('${output_dir}*.sv.qc_metrics.tar.gz')
        Array[File] sv_timing = glob('${output_dir}*.sv.timing_metrics.tar.gz')


    }

    runtime {
        docker: 'quay.io/pancancer/pcawg_delly_workflow:2.2.0'
    }

}

workflow Seqware_Delly_Workflow {
    File reference_gc
    File tumorBam
    File normalBam
    File reference_gz
    File output_dir = '.'
    call Seqware_Delly {
        input:
            reference_gc = reference_gc,
            tumorBam = tumorBam,
            normalBam = normalBam,
            reference_gz = reference_gz,
            output_dir = output_dir
    }
}