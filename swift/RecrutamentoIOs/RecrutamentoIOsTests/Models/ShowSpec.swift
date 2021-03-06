//
//  ShowSpec.swift
//  RecrutamentoIOs
//
//  Created by Thiago Lioy on 1/10/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import Quick
import Nimble
import ModelRocket


@testable import RecrutamentoIOs

class ShowSpec: QuickSpec {
    override func spec() {
        describe("Show") {
            var show: Show!
            beforeEach {
                let json = JsonLoadHelper(filename: "show").load()
                show = Show(json: json!)
            }
            it("should be able to parse json into obj"){
                expect(show).toNot(beNil())
            }
            
            it("should be able to parse json into an array of objs"){
                let js = JsonLoadHelper(filename: "popular_shows").load()
                let shows = Show.parseJSONArray(js!)
                expect(shows.count).to(equal(4))
            }

        }
    }
}
