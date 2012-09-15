package main

import(
    "container/list"
)

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

    // items already processed
    done := list.New()
    // item to be processed
    next := list.New()
    next.PushBack(c)

    for e := next.Front(); e != nil; e = e.Next() {

        // test if the item has already been processed
        alreadyProcessed := false
        for f := done.Front(); f != nil; f = f.Next() {
            if e.Value == f.Value {
                alreadyProcessed = true
                break
            }
        }
        if alreadyProcessed {
            continue
        }

        if e.Value != c {
            done.PushBack(e.Value)
        }

        for _, v := range(D.items[e.Value.(string)]) {
            next.PushBack(v)
        }
    }

    dep := make([]string, done.Len())
    i := 0

    for e := done.Front(); e != nil; e = e.Next() {
        dep[i] = e.Value.(string)
        i++
    }

    return dep
}
