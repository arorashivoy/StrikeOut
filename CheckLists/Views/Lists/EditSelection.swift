//
//  EditSelection.swift
//  CheckLists
//
//  Created by Shivoy Arora on 19/06/21.
//

import SwiftUI

struct EditSelection: View {
	@EnvironmentObject var modelData: ModelData
    @State private var addSheet: Bool = false
	var listEdit: Binding<EditMode>?
	
    var body: some View {
		NavigationView {
			List{
				ForEach(modelData.checkLists){ checkList in
					NavigationLink(
						destination: ListInfo(addSheet: .constant(false), listEdit: listEdit, checkList: checkList)
							.environmentObject(modelData)
							.onDisappear(){
								modelData.checkLists = modelData.checkLists.filter( {$0.id != CheckList.default.id})
							}
					){
						ListRow(checkList: checkList)
					}
				}
				.onDelete(perform: { indexSet in
					modelData.checkLists.remove(atOffsets: indexSet)
				})
                Button{
                    addSheet.toggle()
                    modelData.checkLists.append(CheckList.default)
                }label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20, alignment: .leading)
                        .foregroundColor(.accentColor)
                        .padding(.leading)
                }
                .sheet(isPresented: $addSheet, content: {
                    ListInfo(addSheet: $addSheet, listEdit: .constant(EditMode.inactive), checkList: CheckList.default)
                        .environmentObject(modelData)
                        .onDisappear(){
                            modelData.checkLists = modelData.checkLists.filter( {$0.id != CheckList.default.id})
                        }
                })
			}
			.navigationTitle("Edit Lists")
		}
    }
}

struct EditSelection_Previews: PreviewProvider {
    static var previews: some View {
		EditSelection(listEdit: .constant(EditMode.active))
			.environmentObject(ModelData())
            .preferredColorScheme(.dark)
    }
}
