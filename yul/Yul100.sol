object "Simple" {
    code {
        datacopy(0x0, datasize("runtime"), datasize("runtime"))
        return(0x0, datasize("runtime"))
    }

    object "runtime" {
        code {

        }
    }
}