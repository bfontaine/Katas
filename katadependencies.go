package main

type Dependencies struct {
    items map[string][]string
}

func New_Dependencies() Dependencies {
    return Dependencies{make(map[string][]string)}
}

func (D *Dependencies) add_direct(c string, d []string) {

    // for each dependency
    for _, v := range d {

        // look if it already exists
        if _, ok := D.items[v]; !ok {

            // if not, add it
            D.items[v] = nil
        }
    }

    D.items[c] = d
}

func (D *Dependencies) dependencies_for(c string) []string {
        return nil
}
